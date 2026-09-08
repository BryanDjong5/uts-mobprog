import 'package:flutter/material.dart';

class SportsSectionHeader extends StatelessWidget {
  const SportsSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SPORTS',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          '+ Add sports',
          style: TextStyle(
            color: Color(0xFF6C63FF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
