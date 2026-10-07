// daftarClub/ClubRepository.dart
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


  final ValueNotifier<List<Club>> joinedClubs = ValueNotifier<List<Club>>([]);
  final Set<String> _clubBuatanSendiri = {};
  bool bisaDihapus(String nama) {
    return _clubBuatanSendiri.contains(nama);
  }

  void addClub(Club club) {
    clubs.value = [...clubs.value, club];

    if (club.isJoined) {
      joinedClubs.value = [...joinedClubs.value, club];
    }

    _clubBuatanSendiri.add(club.namaClub);

    NotificationService.instance.notifyClubCreated(
      clubId: club.id,
      clubName: club.namaClub,
    );
  }

  Club? joinedByName(String nama) {
    for (final c in joinedClubs.value) {
      if (c.namaClub == nama) {
        return c;
      }
    }

    return null;
  }

  void setJoin({
    required String nama,
    required String deskripsi,
    required int members,
    required bool joined,
    String? fotoPath,
  }) {
    final sebelumnyaJoin = joinedByName(nama) != null;

    String clubId = nama;

    for (final c in clubs.value) {
      if (c.namaClub == nama) {
        clubId = c.id;
        break;
      }
    }

    clubs.value = [
      for (final c in clubs.value)
        c.namaClub == nama
            ? c.copyWith(
                isJoined: joined,
                members: members,
              )
            : c,
    ];

    final sisa = joinedClubs.value
        .where((c) => c.namaClub != nama)
        .toList();

    joinedClubs.value = joined
        ? [
            ...sisa,
            Club(
              namaClub: nama,
              deskripsiClub: deskripsi,
              members: members,
              isJoined: true,
              fotoPath: fotoPath,
            ),
          ]
        : sisa;

    if (joined && !sebelumnyaJoin) {
      NotificationService.instance.notifyClubJoined(
        clubId: clubId,
        clubName: nama,
      );
    } else if (!joined && sebelumnyaJoin) {
      NotificationService.instance.notifyClubLeft(
        clubId: clubId,
        clubName: nama,
      );
    }
  }

  void hapusClub(String nama) {
  clubs.value = [
    for (final c in clubs.value)
      if (c.namaClub != nama) c,
  ];

  joinedClubs.value = [
    for (final c in joinedClubs.value)
      if (c.namaClub != nama) c,
  ];

  _clubBuatanSendiri.remove(nama);
}

  void hapusSemuaClubBuatanSendiri() {
    clubs.value = [
      for (final c in clubs.value)
        if (!_clubBuatanSendiri.contains(c.namaClub)) c,
    ];

    joinedClubs.value = [
      for (final c in joinedClubs.value)
        if (!_clubBuatanSendiri.contains(c.namaClub)) c,
    ];

    _clubBuatanSendiri.clear();
  }

  void setFoto(String nama, String? path) {
    Club ubah(Club c) {
      return path == null
          ? c.copyWith(hapusFoto: true)
          : c.copyWith(fotoPath: path);
    }

    clubs.value = [
      for (final c in clubs.value)
        c.namaClub == nama ? ubah(c) : c,
    ];

    joinedClubs.value = [
      for (final c in joinedClubs.value)
        c.namaClub == nama ? ubah(c) : c,
    ];
  }

  void _update(String id, Club Function(Club) ubah) {
    clubs.value = [
      for (final c in clubs.value)
        c.id == id ? ubah(c) : c,
    ];
  }

  // Update foto berdasarkan ID
  void updateFoto(String id, String? path) {
    _update(
      id,
      (c) => path == null
          ? c.copyWith(hapusFoto: true)
          : c.copyWith(fotoPath: path),
    );
  }

  void updateJoin(
    String id,
    bool joined,
    int members,
  ) {
    final before = clubs.value
        .where((c) => c.id == id)
        .toList();

    _update(
      id,
      (c) => c.copyWith(
        isJoined: joined,
        members: members,
      ),
    );

    if (before.isNotEmpty &&
        before.first.isJoined != joined) {
      final name = before.first.namaClub;

      if (joined) {
        NotificationService.instance.notifyClubJoined(
          clubId: id,
          clubName: name,
        );
      } else {
        NotificationService.instance.notifyClubLeft(
          clubId: id,
          clubName: name,
        );
      }
    }
  }
}

