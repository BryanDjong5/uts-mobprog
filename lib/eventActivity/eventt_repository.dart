// FILE BARU
import 'package:flutter/foundation.dart';

class EventRepository {
  EventRepository._internal();

  static final EventRepository instance = EventRepository._internal();

  // Daftar event yang sudah didaftar user
  final ValueNotifier<List<Map<String, dynamic>>> eventSaya =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // Id event = judul + tanggal (ada judul sama di tanggal berbeda)
  String _id(Map<String, dynamic> event) =>
      '${event["judul"]}|${event["tanggal"]}';

  bool sudahDaftar(Map<String, dynamic> event) {
    final id = _id(event);
    return eventSaya.value.any((e) => _id(e) == id);
  }

  // true = berhasil ditambah, false = sudah pernah didaftar
  bool daftar(Map<String, dynamic> event) {
    if (sudahDaftar(event)) return false;

    eventSaya.value = [
      ...eventSaya.value,
      {...event, "kuota": "Terdaftar"},
    ];
    return true;
  }
}