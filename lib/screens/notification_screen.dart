import 'package:flutter/material.dart';

import '../Models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatelessWidget {
  final void Function(AppNotification notification)? onNotificationTap;

  const NotificationScreen({super.key, this.onNotificationTap});

  Future<void> _confirmClear(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus semua notifikasi?'),
        content: const Text('Semua notifikasi akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    if (confirm == true) {
      NotificationService.instance.clearAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = NotificationService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2B2D42),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'read_all') {
                service.markAllAsRead();
              } else if (value == 'clear_all') {
                _confirmClear(context);
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'read_all',
                child: Text('Tandai semua dibaca'),
              ),
              PopupMenuItem(value: 'clear_all', child: Text('Hapus semua')),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder<List<AppNotification>>(
        valueListenable: service.notifications,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 72,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada notifikasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Notifikasi tentang klub dan event kamu akan muncul di sini',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                key: ValueKey(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => service.delete(item.id),
                child: _NotificationTile(
                  item: item,
                  onTap: () {
                    service.markAsRead(item.id);
                    onNotificationTap?.call(item);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification item;
  final VoidCallback onTap;

  const _NotificationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(item.type);

    return Material(
      color: item.isRead
          ? Colors.transparent
          : const Color(0xFF2B2D42).withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: style.color.withValues(alpha: 0.15),
                child: Icon(style.icon, color: style.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: item.isRead
                            ? FontWeight.w500
                            : FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.body,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _timeAgo(item.createdAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (!item.isRead)
                Container(
                  margin: const EdgeInsets.only(top: 6, left: 8),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TileStyle {
  final IconData icon;
  final Color color;
  const _TileStyle(this.icon, this.color);
}

_TileStyle _styleFor(String type) {
  switch (type) {
    case 'event_join':
      return const _TileStyle(Icons.event_available, Colors.green);
    case 'event_reminder':
      return const _TileStyle(Icons.alarm, Colors.orange);
    case 'club_join':
      return const _TileStyle(Icons.groups, Colors.blue);
    case 'club_leave':
      return const _TileStyle(Icons.logout, Colors.redAccent);
    case 'club_created':
      return const _TileStyle(Icons.add_circle_outline, Colors.purple);
    default:
      return const _TileStyle(Icons.notifications, Color(0xFF2B2D42));
  }
}

String _timeAgo(DateTime time) {
  final diff = DateTime.now().difference(time);
  if (diff.inSeconds < 60) return 'Baru saja';
  if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
  if (diff.inHours < 24) return '${diff.inHours} jam lalu';
  if (diff.inDays < 7) return '${diff.inDays} hari lalu';
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${time.day} ${months[time.month - 1]} ${time.year}';
}
