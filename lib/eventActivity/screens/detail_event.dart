import 'package:flutter/material.dart';

class LayarDetail extends StatelessWidget {
  final String judul;
  final String kategori;
  final String tanggal;
  final String waktu;
  final String lokasi;
  final String detailLengkap;
  final String kuota;
  final String penyelenggara;
  final String pendaftaran;
  final String syarat;

  const LayarDetail({
    super.key,
    required this.judul,
    required this.kategori,
    required this.tanggal,
    required this.waktu,
    required this.lokasi,
    required this.detailLengkap,
    required this.kuota,
    required this.penyelenggara,
    required this.pendaftaran,
    required this.syarat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF8FF),
      appBar: AppBar(
        title: Text(
          "Detail $judul",
          style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 186, 210, 247),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              judul,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              kategori,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month, 
                  color: Colors.grey, size: 20
                ),
                const SizedBox(width: 8),
                Text(
                  tanggal, style: 
                  const TextStyle(fontSize: 16)
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  waktu,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  lokasi,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 40,
              thickness: 1,
            ),
            const Text(
              "Deskripsi Acara",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              detailLengkap,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Penyelenggara",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              penyelenggara,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Pendaftaran",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pendaftaran,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Syarat & Ketentuan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              syarat,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Kuota",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kuota,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}