import 'package:flutter/material.dart';
import '../Models/Club.dart';
import 'package:uts_mobprog/daftarClub/AddNewClub.dart';

class ListClub extends StatefulWidget {
  const ListClub({super.key});

  @override
  State<ListClub> createState() => _ListClubState();
}

class _ListClubState extends State<ListClub> {
  final List<Club> clubs = [
    Club(
      namaClub: 'Gym Man',
      deskripsiClub: 'Komunitas gym pembentuk otot',
      members: 50,
    ),
    Club(
      namaClub: 'Gamedev',
      deskripsiClub: 'Komunitas tongkrongan para game developer',
      members: 38,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('ReClub'),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),

        itemCount: clubs.length,

        itemBuilder: (context, index) {
          final club = clubs[index];

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
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '${club.members} Members',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NambahClub(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}