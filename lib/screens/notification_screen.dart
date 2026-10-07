import 'package:flutter/material.dart';

import '../Models/notification_model.dart';
import '../services/notification_service.dart';
import '../widgets/notification_filter_bar.dart';

class NotificationScreen extends StatefulWidget {
  final void Function(AppNotification notification)? onNotificationTap;

  const NotificationScreen({super.key, this.onNotificationTap});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationFilter _filter = NotificationFilter.semua;

  Future<void> _confirmClear() async {
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

  String _groupLabel(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(time.year, time.month, time.day);
    final diff = today.difference(day).inDays;
    if (diff <= 0) return 'Hari ini';
    if (diff == 1) return 'Kemarin';
    return 'Sebelumnya';
  }

  List<Object> _buildEntries(List<AppNotification> items) {
    final entries = <Object>[];
    String? lastLabel;
    for (final item in items) {
      final label = _groupLabel(item.createdAt);
      if (label != lastLabel) {
        entries.add(label);
        lastLabel = label;
      }
      entries.add(item);
    }
    return entries;
  }

  Widget _emptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
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
                _confirmClear();
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
        builder: (context, all, _) {
          final unread = all.where((n) => !n.isRead).toList();
          final visible = _filter == NotificationFilter.semua ? all : unread;
          final entries = _buildEntries(visible);

          Widget content;
          if (all.isEmpty) {
            content = _emptyState(
              icon: Icons.notifications_none,
              title: 'Belum ada notifikasi',
              subtitle:
                  'Notifikasi tentang klub dan event kamu akan muncul di sini',
            );
          } else if (visible.isEmpty) {
            content = _emptyState(
              icon: Icons.done_all,
              title: 'Semua sudah dibaca',
              subtitle: 'Tidak ada notifikasi yang belum dibaca',
            );
          } else {
            content = ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];

                if (entry is String) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                    child: Text(
                      entry,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                final item = entry as AppNotification;
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NotificationTile(
                        item: item,
                        onTap: () {
                          service.markAsRead(item.id);
                          widget.onNotificationTap?.call(item);
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                );
              },
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: NotificationFilterBar(
                  selected: _filter,
                  totalCount: all.length,
                  unreadCount: unread.length,
                  onChanged: (value) => setState(() => _filter = value),
                ),
              ),
              Expanded(child: content),
            ],
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
          ? Colors.white
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
