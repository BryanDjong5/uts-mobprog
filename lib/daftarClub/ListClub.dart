import 'package:flutter/material.dart';

class ListClub extends StatefulWidget {
  const ListClub({super.key});

  @override
  State<ListClub> createState() => _ListClubState();
}

class _ListClubState extends State<ListClub> {
  int ListClub = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReClub'),
      ),

      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,

        children: List.generate(ListClub, (index) {
          return Card(
            child: Center(
              child: Text(
                'Club ${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ListClub++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}