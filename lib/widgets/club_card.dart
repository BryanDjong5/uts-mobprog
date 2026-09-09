import 'package:flutter/material.dart';

class ClubCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData; // Sudah disesuaikan menjadi iconData
  final VoidCallback? onTap;

  const ClubCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData, // Sudah disesuaikan
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), 
            blurRadius: 10,
            offset: const Offset(0, 4), 
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0), 
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1), 
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(iconData, color: Colors.blueAccent, size: 28), // Memanggil iconData
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}