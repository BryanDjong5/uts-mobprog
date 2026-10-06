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

  void addClub(Club club) {
    clubs.value = [...clubs.value, club];
  }
}