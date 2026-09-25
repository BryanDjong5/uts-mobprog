// daftarClub/ClubDetail.dart
import 'package:flutter/material.dart';

class ClubDetail extends StatefulWidget {
  final String title;
  final String subtitle;
  final String iconData;
  final int members;
  final String description;

  const ClubDetail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    this.members = 0,
    this.description = '',
  });

  @override
  State<ClubDetail> createState() => _ClubDetailPage();
}

class _ClubDetailPage extends State<ClubDetail> {
  bool isJoined = false;

  void _toggleIsJoined() {
    setState(() {
      isJoined = !isJoined;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isJoined
              ? 'Anda berhasil join ${widget.title}!'
              : 'Anda keluar dari ${widget.title}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 55,
                child: Text(
                  widget.iconData,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Jumlah Member'),
                subtitle: Text('${widget.members + (isJoined ? 1:0)} anggota'),
              ),
            ),

            const SizedBox(height: 12),

            // Deskripsi
            const Text(
              'Tentang Club',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.description.isEmpty
                  ? widget.subtitle
                  : widget.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            // Status Join
            if (isJoined)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green.shade100,
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Anda sudah bergabung dengan club ini',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _toggleIsJoined,
                icon: Icon(
                  isJoined ? Icons.exit_to_app : Icons.group_add,
                ),
                label: Text(
                  isJoined ? 'Leave Club' : 'Join Club',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

