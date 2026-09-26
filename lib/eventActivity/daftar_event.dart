import 'package:flutter/material.dart';

class LayarFormDaftar extends StatefulWidget {
  final String namaKlub;

  const LayarFormDaftar({super.key, required this.namaKlub});

  @override
  State<LayarFormDaftar> createState() => _LayarFormDaftarState();
}

class _LayarFormDaftarState extends State<LayarFormDaftar> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  final TextEditingController _kelaminController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Form Pendaftaran",
          style: TextStyle(color: Colors.black),
        ),
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
                  widget.namaKlub,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _tglLahirController,
                    decoration: InputDecoration(
                      labelText: "Tanggal Lahir",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _kelaminController,
                    decoration: InputDecoration(
                      labelText: "Jenis Kelamin",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_namaController.text.trim().isEmpty ||
                            _tglLahirController.text.trim().isEmpty ||
                            _kelaminController.text.trim().isEmpty ||
                            _alamatController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Lengkapi semua data dahulu!"),
                              backgroundColor: Colors.red, 
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Berhasil mendaftar ke ${widget.namaKlub}!"),
                              backgroundColor: Colors.grey[800], 
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Kirim ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
