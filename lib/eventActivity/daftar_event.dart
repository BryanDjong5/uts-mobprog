import 'package:flutter/material.dart';

class LayarFormDaftar extends StatelessWidget {
  final String namaKlub;

  const LayarFormDaftar({super.key, required this.namaKlub});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Form Pendaftaran", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.amber,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
              color: Colors.amber[100],
              child: Center(
                child: Text(
                  namaKlub, 
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const TextField(decoration: InputDecoration(labelText: "Nama Lengkap", border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  const TextField(decoration: InputDecoration(labelText: "Tanggal Lahir", border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  const TextField(decoration: InputDecoration(labelText: "Jenis Kelamin", border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  const TextField(decoration: InputDecoration(labelText: "Alamat", border: OutlineInputBorder())),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Daftar", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}