class EventItem {
  final String id;
  final String nama;
  final String deskripsi;
  final String lokasi;
  final String kategori;
  final DateTime tanggal;
  final int harga;
  final int peserta;
  final int kuota;
  final bool isJoined;

  const EventItem({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.lokasi,
    required this.kategori,
    required this.tanggal,
    required this.harga,
    required this.peserta,
    required this.kuota,
    this.isJoined = false,
  });

  EventItem copyWith({int? peserta, bool? isJoined}) {
    return EventItem(
      id: id,
      nama: nama,
      deskripsi: deskripsi,
      lokasi: lokasi,
      kategori: kategori,
      tanggal: tanggal,
      harga: harga,
      peserta: peserta ?? this.peserta,
      kuota: kuota,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
