import 'package:flutter/material.dart';
import '../screens/daftar_event.dart';
import '../screens/detail_event.dart';


class Event extends StatelessWidget {
  final String judul;
  final String kategori;
  final IconData iconKategori;
  final String waktu;
  final String lokasi;
  final String detail;
  final String detailLengkap;
  final String kuota;
  final String penyelenggara;
  final String pendaftaran;
  final String syarat;
  final String tanggal;
const Event({
    super.key,
    required this.judul,
    required this.kategori,
    required this.iconKategori,
    required this.waktu,
    required this.lokasi,
    required this.detail,
    required this.detailLengkap,
    required this.kuota,
    required this.penyelenggara,
    required this.pendaftaran,
    required this.syarat,
    required this.tanggal,
  });

  int _getAngka() {
    try {
      String angka = kuota.replaceAll(RegExp(r'[^0-9]'), '');
      return int.parse(angka);
    } catch (e) {
      return 0; 
    }
  }

  @override
  Widget build(BuildContext context) {
    final int angkaSlot = _getAngka();
    final Color warnaBg = angkaSlot > 10
        ? Colors.green[100]!
        : (angkaSlot > 3 ? Colors.orange[100]! : Colors.red[100]!);
        
    final Color warnaTeks = angkaSlot > 10
        ? Colors.green[800]!
        : (angkaSlot > 3 ? Colors.deepOrange : Colors.red[800]!);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell( 
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LayarDetail(
                judul: judul,
                kategori: kategori,
                tanggal: tanggal,
                waktu: waktu,
                lokasi: lokasi,
                detailLengkap: detailLengkap,
                kuota: kuota,
                penyelenggara: penyelenggara,
                pendaftaran: pendaftaran,
                syarat: syarat,
              ),
            ),
          );
        },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  iconKategori,size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  kategori,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(waktu, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(lokasi, style: TextStyle(color: Colors.grey[700])),
              ],
            ),

            const Divider(height: 24, thickness: 1),

            const Text(
              "Detail Event:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(detail, style: const TextStyle(fontSize: 14, height: 1.4)),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: warnaBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    kuota,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: warnaTeks,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LayarFormDaftar(
                          namaKlub: judul,
                           event: {
                            "judul": judul,
                            "kategori": kategori,
                            "icon": iconKategori,
                            "tanggal": tanggal,
                            "waktu": waktu,
                            "lokasi": lokasi,
                            "detail": detail,
                            "detail_lengkap": detailLengkap,
                            "kuota": kuota,
                            "penyelenggara": penyelenggara,
                            "pendaftaran": pendaftaran,
                            "syarat": syarat,
                          },
                        ),
                        ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Daftar Event",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
  );
  }
}

