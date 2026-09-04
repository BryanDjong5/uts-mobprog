import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReClub Beranda'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Menghilangkan tombol back bawaan
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang di ReClub!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Temukan berbagai komunitas seru di sekitarmu.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            
            Expanded(
              child: ListView(
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.group, color: Colors.blue, size: 40),
                    title: Text(
                        'Klub Belajar Flutter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Diskusi dan ngoding bareng setiap minggu.'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.sports_esports, color: Colors.blue, size: 40),
                      title: Text(
                        'Klub Game & Esport',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Mabar seru dan turnamen internal.'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
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