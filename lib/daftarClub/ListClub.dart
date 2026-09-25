// daftarClub/ListClub.dart
import 'package:flutter/material.dart';
import '../Models/Club.dart';
import 'package:uts_mobprog/daftarClub/AddNewClub.dart';
import 'ClubRepository.dart';

class ListClub extends StatefulWidget {
  const ListClub({super.key});

  @override
  State<ListClub> createState() => _ListClubState();
}

class _ListClubState extends State<ListClub> {
  void tambahClub() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NambahClub()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ReClub')),
      body: ValueListenableBuilder<List<Club>>(
        valueListenable: ClubRepository.instance.clubs,
        builder: (context, clubList, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: clubList.length,
            itemBuilder: (context, index) {
              final club = clubList[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        club.namaClub,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        club.deskripsiClub,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        '${club.members} Members',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tambahClub,
        child: const Icon(Icons.add),
      ),
    );
  }
}