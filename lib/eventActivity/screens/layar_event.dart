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
      "icon": Icons.sports_tennis,
      "waktu": "18:00 WIB",
      "lokasi": "Lapangan Futsal",
      "detail": "Main futsal santai",
      "kuota": "3 Slot"
    },
    {
      "judul": "Bulu Tangkis",
      "kategori": "Olahraga",
      "icon": Icons.sports_tennis,
      "waktu": "16:00 WIB", 
      "lokasi": "Jakbar",
      "detail": "Main main aja",
      "kuota": "2 Slot"
    },
    {
      "judul": "Nyanyi",
      "kategori": "Musik",
      "icon": Icons.music_note,
      "waktu": "16:00 WIB", 
      "lokasi": "Jakbar",
      "detail": "Main main aja",
      "kuota": "2 Slot"
    },
  ];
 
  List<Map<String, dynamic>> tampilEvent = []; 
  String kategoriAktif = 'Semua';
  String keyword = '';
  final List<String> daftarKategori = ['Semua', 'Olahraga', 'Musik'];

  @override
  void initState() {
    super.initState();
    tampilEvent = daftarEvent; 
  }

  void saringData() {
    List<Map<String, dynamic>> hasil = daftarEvent;
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
                  context,
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
  
  