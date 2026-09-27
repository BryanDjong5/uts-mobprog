import 'package:flutter/material.dart';

class LayarDetail extends StatelessWidget {
  final String judul;
  final String kategori;
  final String waktu;
  final String lokasi;
  final String detailLengkap;

  const LayarDetail({
    super.key,
    required this.judul,
    required this.kategori,
    required this.waktu,
    required this.lokasi,
    required this.detailLengkap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Detail $judul",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber,
        iconTheme: const IconThemeData(
          color: Colors.black,
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
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.amber,
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
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.grey,
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
          ],
        ),
      ),
    );
  }
}