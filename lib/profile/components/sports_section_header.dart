import 'package:flutter/material.dart';

class SportsSectionHeader extends StatelessWidget {
  final VoidCallback? onAddSportTap;

  const SportsSectionHeader({super.key, this.onAddSportTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SPORTS',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.grey.shade600,
          ),
        ),
        InkWell(
          onTap: onAddSportTap,
          child: const Text(
            'Add Sport',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF274FED),
            ),
          ),
        ),
      ],
    );
  }
}
