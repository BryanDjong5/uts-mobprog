import 'package:flutter/material.dart';

enum NotificationFilter { semua, belumDibaca }

class NotificationFilterBar extends StatelessWidget {
  final NotificationFilter selected;
  final int totalCount;
  final int unreadCount;
  final ValueChanged<NotificationFilter> onChanged;

  const NotificationFilterBar({
    super.key,
    required this.selected,
    required this.totalCount,
    required this.unreadCount,
    required this.onChanged,
  });

  Widget _tab({
    required NotificationFilter value,
    required String label,
    required int count,
    required bool showBadge,
  }) {
    final isSelected = selected == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF2B2D42) : Colors.black54,
              ),
            ),
            if (showBadge && count > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EAF0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _tab(
              value: NotificationFilter.semua,
              label: 'Semua',
              count: totalCount,
              showBadge: false,
            ),
          ),
          Expanded(
            child: _tab(
              value: NotificationFilter.belumDibaca,
              label: 'Belum dibaca',
              count: unreadCount,
              showBadge: true,
            ),
          ),
        ],
      ),
    );
  }
}
