import 'package:flutter/material.dart';
import '../widgets/widget_event.dart';
import '../eventt_repository.dart'; 

class LayarEventSaya extends StatelessWidget {
  const LayarEventSaya({super.key});

  @override
  Widget build(BuildContext context) {
    // DIHAPUS: list dummy eventSaya, diganti data dari EventRepository

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8FF),
      appBar: AppBar(
        title: const Text(
          "Event Saya",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // DIUBAH: body dibungkus ValueListenableBuilder supaya otomatis
      // update tiap ada event baru yang didaftar
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: EventRepository.instance.eventSaya,
        builder: (context, eventSaya, _) {
          if (eventSaya.isEmpty) {
            return const Center(
              child: Text(
                "Kamu belum mendaftar event apapun.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: eventSaya.length,
            itemBuilder: (context, index) {
              final event = eventSaya[index];
              return Event(
                judul: event["judul"]!,
                kategori: event["kategori"]!,
                iconKategori: event["icon"],
                waktu: event["waktu"]!,
                lokasi: event["lokasi"]!,
                detail: event["detail"]!,
                detailLengkap: event["detail_lengkap"]!,
                kuota: event["kuota"]!,
                tanggal: event["tanggal"]!,
                penyelenggara: event["penyelenggara"] ?? '-',
                pendaftaran: event["pendaftaran"] ?? '-',
                syarat: event["syarat"] ?? '-',
              );
            },
          );
        },
      ),
    );
  }
}