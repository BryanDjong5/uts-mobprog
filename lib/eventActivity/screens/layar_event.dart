import 'package:flutter/material.dart';
import '../widgets/widget_kalender.dart';
import '../widgets/widget_event.dart';

class LayarEvent extends StatefulWidget {
  const LayarEvent({super.key});

  @override
  State<LayarEvent> createState() => _LayarEventState();
}

class _LayarEventState extends State<LayarEvent> {

  final List<Map<String, dynamic>> daftarEvent = [
    {
      "judul": "Futsal",
      "kategori": "Olahraga",
      "tanggal": "6",
      "icon": Icons.sports_tennis,
      "waktu": "18:00 WIB",
      "lokasi": "Lapangan Futsal",
      "detail": "Main futsal santai",
      "kuota": "3 Slot"
    },
    {
      "judul": "Bulu Tangkis",
      "kategori": "Olahraga",
      "tanggal": "6",
      "icon": Icons.sports_tennis,
      "waktu": "16:00 WIB", 
      "lokasi": "Jakbar",
      "detail": "Main main aja",
      "kuota": "2 Slot"
    },
    {
      "judul": "Nyanyi",
      "kategori": "Musik",
      "tanggal": "6",
      "icon": Icons.music_note,
      "waktu": "16:00 WIB", 
      "lokasi": "Jakbar",
      "detail": "Main main aja",
      "kuota": "2 Slot"
    },
    {
      "judul": "PSUT",
      "kategori": "Musik", 
      "tanggal": "7", 
      "icon": Icons.music_note,
      "waktu": "09:00 WIB",
      "lokasi": "Panggung",
      "detail": "Lomba menyanyi",
      "kuota": "10 Slot"
    },
    {
      "judul": "Padus",
      "kategori": "Musik", 
      "tanggal": "8", 
      "icon": Icons.music_note,
      "waktu": "13:00 WIB",
      "lokasi": "Graha",
      "detail": "Lomba paduan suara",
      "kuota": "100 Slot"
    },
    {
      "judul": "Futsal",
      "kategori": "Olahraga",
      "tanggal": "7",
      "icon": Icons.sports_tennis,
      "waktu": "18:00 WIB",
      "lokasi": "Lapangan Futsal",
      "detail": "Main futsal santai",
      "kuota": "12 Slot"
    },
    {
      "judul": "Basket",
      "kategori": "Olahraga",
      "tanggal": "9",
      "icon": Icons.sports_tennis,
      "waktu": "18:00 WIB",
      "lokasi": "Lapangan Futsal",
      "detail": "Main futsal santai",
      "kuota": "6 Slot"
    },
  ];
 
  List<Map<String, dynamic>> tampilEvent = []; 
  String tanggalAktif = '6';

  @override
  void initState() {
    super.initState();
    tampilEvent = daftarEvent; 
    saringData();
  }

  void saringData() {
    List<Map<String, dynamic>> hasil = daftarEvent;
    hasil = hasil.where((event) => event["tanggal"] == tanggalAktif).toList();

    setState(() {
      tampilEvent = hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF8FF),
      appBar: AppBar(
        title: Text("Jadwal & Event", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.bookmark, color: Color(0xFF4285F4), size: 18),
              label: const Text(
                "Event Saya",
                style: TextStyle(
                  color: Color(0xFF4285F4),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.lightBlueAccent, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
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
                Kalender("WED", "6", tanggalAktif == "6", onTap: () {
                  setState(() {
                    tanggalAktif = "6";
                    saringData();
                  });
                }),
                Kalender("THU", "7", tanggalAktif == "7", onTap: () {
                  setState(() {
                    tanggalAktif = "7";
                    saringData();
                  });
                }),
                Kalender("FRI", "8", tanggalAktif == "8", onTap: () {
                  setState(() {
                    tanggalAktif = "8";
                    saringData();
                  });
                }),
                Kalender("SAT", "9", tanggalAktif == "9", onTap: () {
                  setState(() {
                    tanggalAktif = "9";
                    saringData();
                  });
                }),
                Kalender("SUN", "10", tanggalAktif == "10", onTap: () {
                  setState(() {
                    tanggalAktif = "10";
                    saringData();
                  });
                }),
                Kalender("MON", "11", tanggalAktif == "11", onTap: () {
                  setState(() {
                    tanggalAktif = "11";
                    saringData();
                  });
                }),
                const SizedBox(width: 16),
              ],
            ),
          ),

          const SizedBox(height: 40),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tampilEvent.length,
              itemBuilder: (context, index) {
                final event = tampilEvent[index]; 
                return Event(
                  judul: event["judul"]!,
                  kategori: event["kategori"]!, 
                  iconKategori: event["icon"],
                  waktu: event["waktu"]!,
                  lokasi: event["lokasi"]!,
                  detail: event["detail"]!,
                  kuota: event["kuota"]!,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
  
  