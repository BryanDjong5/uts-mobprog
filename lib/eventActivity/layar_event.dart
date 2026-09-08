import 'package:flutter/material.dart';

class LayarEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Jadwal & Event", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.amber,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Kalender("WED", "6", true),
                Kalender("THU", "7", false),
                Kalender("FRI", "8", false),
                Kalender("SAT", "9", false),
                Kalender("SUN", "10", false),
                Kalender("MON", "11", false),
                const SizedBox(width: 16),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Event(
              judul: "Futsal",
              kategori: "Olahraga",
              waktu: "18:00 WIB",
              lokasi: "Lapangan Futsal",
              detail: "Main futsal santai",
              kuota: "3 Slot",
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Event(
              judul: "Bulu Tangkis",
              kategori: "Olahraga",
              waktu: "16:00 WIB",
              lokasi: "Jakbar",
              detail: "Main main aja.",
              kuota: "2 Slot",
            ),
          ),
        ],
      ),
    );
  }

  Widget Kalender(String hari, String tanggal, bool isAktif) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isAktif ? Colors.greenAccent[700] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hari,
            style: TextStyle(
              fontSize: 12,
              color: isAktif ? Colors.white : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tanggal,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isAktif ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget Event({
    required String judul,
    required String kategori,
    required String waktu,
    required String lokasi,
    required String detail,
    required String kuota,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                const Icon(Icons.sports_tennis, size: 16, color: Colors.grey),
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
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    kuota,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
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
    );
  }
}
