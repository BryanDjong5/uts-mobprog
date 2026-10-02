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
  ];
 
  List<Map<String, dynamic>> tampilEvent = []; 
  String kategoriAktif = 'Semua';
  String keyword = '';
  String tanggalAktif = '6';
  final List<String> daftarKategori = ['Semua', 'Olahraga', 'Musik'];

  @override
  void initState() {
    super.initState();
    tampilEvent = daftarEvent; 
    saringData();
  }

  void saringData() {
    List<Map<String, dynamic>> hasil = daftarEvent;
    hasil = hasil.where((event) => event["tanggal"] == tanggalAktif).toList();
    if (kategoriAktif != 'Semua') {
      hasil = hasil.where((event) => event["kategori"] == kategoriAktif).toList();
    }
   if (keyword.isNotEmpty) {
      hasil = hasil
          .where((event) => event["judul"]
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      tampilEvent = hasil;
    });

    void ubahTanggal(String tanggalPilihan) {
    setState(() {
      tanggalAktif = tanggalPilihan;
      saringData();
    });
    }
  }

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

          const SizedBox(height: 30),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (teks) {
                keyword = teks;
                saringData(); 

              },
              decoration: InputDecoration(
                hintText: "Cari nama event",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ), 
            ),
          ),

          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: daftarKategori.map((kategori) {
                final bool isAktif = kategoriAktif == kategori;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      kategori,
                      style: TextStyle(
                        color: isAktif ? Colors.white : Colors.black87,
                        fontWeight: isAktif ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isAktif,
                    selectedColor: Colors.amber[700],
                    backgroundColor: Colors.grey[200],
                    showCheckmark: false, 
                    onSelected: (selected) {
                      kategoriAktif = kategori;
                      saringData(); 
                    },
                  ),
                );
              }).toList(),
            ),
          ),

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
  
  