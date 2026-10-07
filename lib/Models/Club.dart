// Models/Club.dart
class Club {
  static int _counter = 0;

  final String id;
  final String namaClub;
  final String deskripsiClub;
  final int members;
  final bool isJoined;
  final String? fotoPath;

  Club({
    String? id,
    required this.namaClub,
    required this.deskripsiClub,
    required this.members,
    required this.isJoined,
    this.fotoPath,
  }) : id = id ?? 'club_${_counter++}';

  Club copyWith({
    int? members,
    bool? isJoined,
    String? fotoPath,
    bool hapusFoto = false,
  }) {
    return Club(
      id: id,
      namaClub: namaClub,
      deskripsiClub: deskripsiClub,
      members: members ?? this.members,
      isJoined: isJoined ?? this.isJoined,
      fotoPath: hapusFoto ? null : (fotoPath ?? this.fotoPath),
    );
  }
}
