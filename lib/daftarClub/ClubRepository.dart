// daftarClub/ClubRepository.dart
import 'package:flutter/foundation.dart';
import '/Models/Club.dart';

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

  void addClub(Club club) {
    clubs.value = [...clubs.value, club];
    if (club.isJoined) {
      joinedClubs.value = [...joinedClubs.value, club];
    }
  }

  Club? joinedByName(String nama) {
    for (final c in joinedClubs.value) {
      if (c.namaClub == nama) return c;
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
    clubs.value = [
      for (final c in clubs.value)
        c.namaClub == nama ? c.copyWith(isJoined: joined, members: members) : c,
    ];

    final sisa = joinedClubs.value.where((c) => c.namaClub != nama).toList();
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
  }

  void setFoto(String nama, String? path) {
    Club ubah(Club c) => path == null
        ? c.copyWith(hapusFoto: true)
        : c.copyWith(fotoPath: path);

    clubs.value = [
      for (final c in clubs.value) c.namaClub == nama ? ubah(c) : c,
    ];
    joinedClubs.value = [
      for (final c in joinedClubs.value) c.namaClub == nama ? ubah(c) : c,
    ];
  }
}