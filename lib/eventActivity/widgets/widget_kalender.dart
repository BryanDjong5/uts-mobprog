import 'package:flutter/material.dart';

Widget Kalender(String hari, String tanggal, bool isAktif) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isAktif ? Colors.greenAccent[700] : Colors.grey[200],
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
    );
  }
