import 'package:flutter/foundation.dart';

import '../Models/notification_model.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final ValueNotifier<List<AppNotification>> notifications =
      ValueNotifier<List<AppNotification>>(_seed());

  int _counter = 0;

  static List<AppNotification> _seed() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: 'seed_1',
        title: 'Selamat datang di ReClub',
        body: 'Temukan klub dan event seru di sekitarmu.',
        type: 'general',
        refId: null,
        isRead: false,
        createdAt: now.subtract(const Duration(minutes: 5)),
      ),
      AppNotification(
        id: 'seed_2',
        title: 'Event baru tersedia',
        body: 'Cek halaman pencarian untuk melihat event minggu ini.',
        type: 'event_reminder',
        refId: null,
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
    ];
  }

  int get unreadCount => notifications.value.where((n) => !n.isRead).length;

  void send({
    required String title,
    required String body,
    String type = 'general',
    String? refId,
  }) {
    final item = AppNotification(
      id: 'notif_${_counter++}',
      title: title,
      body: body,
      type: type,
      refId: refId,
      isRead: false,
      createdAt: DateTime.now(),
    );
    notifications.value = [item, ...notifications.value];
  }

  void notifyClubJoined({required String clubId, required String clubName}) {
    send(
      title: 'Berhasil bergabung',
      body: 'Kamu sekarang anggota $clubName',
      type: 'club_join',
      refId: clubId,
    );
  }

  void notifyClubLeft({required String clubId, required String clubName}) {
    send(
      title: 'Keluar dari klub',
      body: 'Kamu sudah keluar dari $clubName',
      type: 'club_leave',
      refId: clubId,
    );
  }

  void notifyClubCreated({required String clubId, required String clubName}) {
    send(
      title: 'Klub berhasil dibuat',
      body: 'Klub $clubName sudah ditambahkan',
      type: 'club_created',
      refId: clubId,
    );
  }

  void notifyEventJoined({
    required String eventId,
    required String eventTitle,
  }) {
    send(
      title: 'Pendaftaran event berhasil',
      body: 'Kamu terdaftar di event $eventTitle',
      type: 'event_join',
      refId: eventId,
    );
  }

  void markAsRead(String id) {
    notifications.value = [
      for (final n in notifications.value)
        n.id == id ? n.copyWith(isRead: true) : n,
    ];
  }

  void markAllAsRead() {
    notifications.value = [
      for (final n in notifications.value) n.copyWith(isRead: true),
    ];
  }

  void delete(String id) {
    notifications.value = notifications.value.where((n) => n.id != id).toList();
  }

  void clearAll() {
    notifications.value = [];
  }
}
