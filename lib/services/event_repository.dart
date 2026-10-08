import 'package:flutter/foundation.dart';

import '../Models/event_model.dart';
import 'notification_service.dart';

class EventRepository {
  EventRepository._();
  static final EventRepository instance = EventRepository._();

  final ValueNotifier<List<EventItem>> events = ValueNotifier<List<EventItem>>(
    _seed(),
  );

  static List<EventItem> _seed() {
    final now = DateTime.now();
    DateTime at(int days, int hour) {
      return DateTime(now.year, now.month, now.day + days, hour);
    }

    return [
      EventItem(
        id: 'event_1',
        nama: 'Fun Run Kampus',
        deskripsi: 'Lari santai 5K keliling kampus bareng komunitas lari.',
        lokasi: 'Lapangan Utama Kampus',
        kategori: 'Olahraga',
        tanggal: at(2, 6),
        harga: 0,
        peserta: 48,
        kuota: 100,
      ),
      EventItem(
        id: 'event_2',
        nama: 'Workshop Flutter Pemula',
        deskripsi: 'Belajar membuat aplikasi mobile pertama dengan Flutter.',
        lokasi: 'Lab Komputer Gedung C',
        kategori: 'Teknologi',
        tanggal: at(4, 13),
        harga: 25000,
        peserta: 30,
        kuota: 40,
      ),
      EventItem(
        id: 'event_3',
        nama: 'Mabar Valorant Internal',
        deskripsi: 'Turnamen kecil antar anggota klub game dan esport.',
        lokasi: 'Ruang Komunitas',
        kategori: 'Game',
        tanggal: at(5, 19),
        harga: 10000,
        peserta: 16,
        kuota: 20,
      ),
      EventItem(
        id: 'event_4',
        nama: 'Hunting Foto Kota Tua',
        deskripsi: 'Hunting foto bareng, cocok untuk pemula maupun mahir.',
        lokasi: 'Kota Tua Jakarta',
        kategori: 'Fotografi',
        tanggal: at(7, 8),
        harga: 0,
        peserta: 22,
        kuota: 30,
      ),
      EventItem(
        id: 'event_5',
        nama: 'Open Mic Night',
        deskripsi: 'Panggung terbuka untuk band dan solois kampus.',
        lokasi: 'Aula Serbaguna',
        kategori: 'Musik',
        tanggal: at(9, 18),
        harga: 15000,
        peserta: 55,
        kuota: 150,
      ),
      EventItem(
        id: 'event_6',
        nama: 'Turnamen Futsal Antar Fakultas',
        deskripsi: 'Kompetisi futsal tahunan, daftar per tim.',
        lokasi: 'Lapangan Futsal Indoor',
        kategori: 'Olahraga',
        tanggal: at(12, 15),
        harga: 50000,
        peserta: 8,
        kuota: 16,
      ),
    ];
  }

  void join(String id) {
    final index = events.value.indexWhere((e) => e.id == id);
    if (index < 0) return;
    final event = events.value[index];
    if (event.isJoined || event.peserta >= event.kuota) return;

    final updated = [...events.value];
    updated[index] = event.copyWith(peserta: event.peserta + 1, isJoined: true);
    events.value = updated;

    NotificationService.instance.notifyEventJoined(
      eventId: event.id,
      eventTitle: event.nama,
    );
  }
}
