import 'dart:async';

import 'package:flutter/material.dart';

import '../Models/notification_model.dart';
import '../screens/notification_screen.dart';
import '../services/notification_service.dart';

class NotificationBannerHost extends StatefulWidget {
  final Widget child;

  const NotificationBannerHost({super.key, required this.child});

  @override
  State<NotificationBannerHost> createState() => _NotificationBannerHostState();
}

class _NotificationBannerHostState extends State<NotificationBannerHost> {
  final NotificationService _service = NotificationService.instance;
  late final Set<String> _known;
  OverlayEntry? _currentEntry;
  VoidCallback? _dismissCurrent;

  @override
  void initState() {
    super.initState();
    _known = _service.notifications.value.map((n) => n.id).toSet();
    _service.notifications.addListener(_onChanged);
  }

  @override
  void dispose() {
    _service.notifications.removeListener(_onChanged);
    _dismissCurrent?.call();
    super.dispose();
  }

  void _onChanged() {
    final list = _service.notifications.value;
    final fresh = list.where((n) => !_known.contains(n.id)).toList();
    _known.addAll(list.map((n) => n.id));
    if (fresh.isEmpty) return;
    final target = fresh.first;
    Future.microtask(() {
      if (mounted) _show(target);
    });
  }

  void _show(AppNotification notification) {
    _dismissCurrent?.call();
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    var removed = false;
    late final OverlayEntry entry;

    void dismiss() {
      if (removed) return;
      removed = true;
      if (identical(_currentEntry, entry)) {
        _currentEntry = null;
        _dismissCurrent = null;
      }
      entry.remove();
    }

    entry = OverlayEntry(
      builder: (_) => _BannerCard(
        notification: notification,
        onDismiss: dismiss,
        onTap: () {
          dismiss();
          _service.markAsRead(notification.id);
          if (!mounted) return;
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const NotificationScreen()));
        },
      ),
    );

    _currentEntry = entry;
    _dismissCurrent = dismiss;
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _BannerCard extends StatefulWidget {
  final AppNotification notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _BannerCard({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  State<_BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<_BannerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
  );
  late final Animation<Offset> _slide =
      Tween<Offset>(begin: const Offset(0, -1.3), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeIn,
        ),
      );
  Timer? _timer;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(const Duration(seconds: 4), _close);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _close() async {
    if (_closing) return;
    _closing = true;
    _timer?.cancel();
    if (mounted) {
      await _controller.reverse();
    }
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.notification;
    final color = _colorFor(n.type);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: SlideTransition(
          position: _slide,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  _timer?.cancel();
                  widget.onTap();
                },
                onVerticalDragEnd: (details) {
                  if ((details.primaryVelocity ?? 0) < -150) _close();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B2D42),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: color.withValues(alpha: 0.25),
                        child: Icon(_iconFor(n.type), color: color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              n.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              n.body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right, color: Colors.white54),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

IconData _iconFor(String type) {
  switch (type) {
    case 'event_join':
      return Icons.event_available;
    case 'event_reminder':
      return Icons.alarm;
    case 'club_join':
      return Icons.groups;
    case 'club_leave':
      return Icons.logout;
    case 'club_created':
      return Icons.add_circle_outline;
    default:
      return Icons.notifications;
  }
}

Color _colorFor(String type) {
  switch (type) {
    case 'event_join':
      return Colors.greenAccent;
    case 'event_reminder':
      return Colors.orangeAccent;
    case 'club_join':
      return Colors.lightBlueAccent;
    case 'club_leave':
      return Colors.redAccent;
    case 'club_created':
      return Colors.purpleAccent;
    default:
      return Colors.white;
  }
}
