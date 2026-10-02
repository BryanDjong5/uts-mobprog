import 'package:flutter/material.dart';
import 'package:uts_mobprog/daftarClub/ListClub.dart';
import '../Models/Club.dart';

class NambahClub extends StatefulWidget {
  const NambahClub({super.key});

  @override
  State<NambahClub> createState() => _NambahClubState();
}

class _NambahClubState extends State<NambahClub> {
  final TextEditingController namaClub = TextEditingController();
  final TextEditingController deskripsiClub = TextEditingController();

  void createClub() {
    final clubname = namaClub.text.trim();
    final clubdesc = deskripsiClub.text.trim();

    if (clubname.isEmpty || clubdesc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan deskripsi harus diisi'),
        ),
      );

      return;
    }

    final clubBaru = Club(
      namaClub: clubname,
      deskripsiClub: clubdesc,
      members: 1,
      isJoined: true,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Klub berhasil dibuat!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 2),
      )
    );

    Navigator.pop(context, clubBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B2D42), 
        foregroundColor: Colors.white,
        title: const Text('Add Club'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [
            TextField(
              controller: namaClub,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.edit, color: Color(0xFF2B2D42)),
                labelText: 'Masukkan nama club',
                hintText: 'Nama Club',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: deskripsiClub,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description, color: Color(0xFF2B2D42)),
                labelText: 'Masukkan deskripsi club',
                hintText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
                width: double.infinity, // Membuat tombol membentang penuh
                height: 50, // Mengatur tinggi tombol agar enak ditekan
                child: ElevatedButton(
                  onPressed: createClub,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B2D42), // Warna navy
                    foregroundColor: Colors.white, // Warna teks putih
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Melengkungkan sudut
                    ),
                  ),
                  child: const Text(
                    'Create Club',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaClub.dispose();
    deskripsiClub.dispose();
    super.dispose();
  }
}