// daftarClub/AddNewClub.dart
import 'package:flutter/material.dart';
import '../Models/Club.dart';
import '/daftarClub/ClubRepository.dart';

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
        SnackBar(
          content: const Text('Nama dan deskripsi harus diisi'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
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

    ClubRepository.instance.addClub(clubBaru);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Club')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: namaClub,
              decoration: const InputDecoration(
                labelText: 'Masukkan nama club',
                hintText: 'Nama Club',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: deskripsiClub,
              decoration: const InputDecoration(
                labelText: 'Masukkan deskripsi club',
                hintText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: createClub,
              child: const Text('Create Club'),
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