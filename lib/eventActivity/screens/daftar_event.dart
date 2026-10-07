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
  final TextEditingController _alamatController = TextEditingController();
  String jenisKelamin = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF8FF),
      appBar: AppBar(
        title: const Text(
          "Form Pendaftaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
              color: const Color.fromARGB(255, 186, 210, 247),
              child: Center(
                child: Text(
                  "Gambar event",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                     onTap: () async {
                      DateTime? tanggal = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        initialDate: DateTime(2005),
                      );
                      if (tanggal != null) {
                        _tglLahirController.text =
                            "${tanggal.day}/${tanggal.month}/${tanggal.year}";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Tanggal Lahir",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(16),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    decoration: InputDecoration(
                      labelText: "Jenis Kelamin",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Laki-laki", 
                        child: Text("Laki-laki")
                      ),
                      DropdownMenuItem(
                        value: "Perempuan", 
                        child: Text("Perempuan")
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        jenisKelamin = value ?? "";
                      });
                    },
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
                            jenisKelamin.isEmpty ||
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
                              backgroundColor: Colors.green[800], 
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
