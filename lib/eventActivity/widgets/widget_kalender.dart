import 'package:flutter/material.dart';

class Kalender extends StatelessWidget {
  final String hari;
  final String tanggal;
  final bool isAktif;
  final VoidCallback onTap;

  const Kalender(
    this.hari,
    this.tanggal,
    this.isAktif, {
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isAktif ? Color(0xFF4285F4) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hari,
              style: TextStyle(
                fontSize: 12,
                color: isAktif ? Colors.white : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tanggal,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isAktif ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      )
    );
  }
}