import 'package:flutter/foundation.dart';

import '/Models/Club.dart';
import '../services/notification_service.dart';

class ClubRepository {
  ClubRepository._internal();
  static final ClubRepository instance = ClubRepository._internal();

  final ValueNotifier<List<Club>> clubs = ValueNotifier<List<Club>>([
    Club(
      namaClub: 'Klub Fotografi',
      deskripsiClub: 'Hunting foto bareng setiap akhir pekan.',
      members: 35,
      isJoined: false,
    ),
    Club(
      namaClub: 'Klub Musik & Band',
      deskripsiClub: 'Latihan studio dan persiapan manggung.',
      members: 21,
      isJoined: false,
    ),
  ]);

  void addClub(Club club) {
    clubs.value = [...clubs.value, club];
    NotificationService.instance.notifyClubCreated(
      clubId: club.id,
      clubName: club.namaClub,
    );
  }

  void _update(String id, Club Function(Club) ubah) {
    clubs.value = [for (final c in clubs.value) c.id == id ? ubah(c) : c];
  }

  void updateFoto(String id, String? path) {
    _update(
      id,
      (c) => path == null
          ? c.copyWith(hapusFoto: true)
          : c.copyWith(fotoPath: path),
    );
  }

  void updateJoin(String id, bool joined, int members) {
    final before = clubs.value.where((c) => c.id == id).toList();
    _update(id, (c) => c.copyWith(isJoined: joined, members: members));

    if (before.isNotEmpty && before.first.isJoined != joined) {
      final name = before.first.namaClub;
      if (joined) {
        NotificationService.instance.notifyClubJoined(
          clubId: id,
          clubName: name,
        );
      } else {
        NotificationService.instance.notifyClubLeft(clubId: id, clubName: name);
      }
    }
  }
}
