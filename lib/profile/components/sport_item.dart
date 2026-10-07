import 'package:flutter/material.dart';

class SportItemCard extends StatelessWidget {
  final String sportName;
  final String skillLevel;
  final VoidCallback onTap;

  const SportItemCard({
    super.key,
    required this.sportName,
    required this.skillLevel,
    required this.onTap,
  });

  // Fungsi pemeta ikon berdasarkan nama olahraga
  IconData _getSportIcon(String name) {
    switch (name.toLowerCase()) {
      case 'basketball':
        return Icons.sports_basketball;
      case 'soccer':
        return Icons.sports_soccer;
      case 'volleyball':
        return Icons.sports_volleyball;
      case 'badminton':
      case 'tennis':
      case 'padel':
      case 'table tennis':
        return Icons.sports_tennis;
      case 'swimming':
        return Icons.pool;
      case 'running':
        return Icons.directions_run;
      default:
        return Icons.sports;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF274FED).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getSportIcon(sportName), // Dynamic Icon berdasarkan sportName
                color: const Color(0xFF274FED),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sportName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    skillLevel,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
