import 'package:flutter/material.dart';

class SupportBanner extends StatelessWidget {
  final VoidCallback? onSupportTap;

  const SupportBanner({super.key, this.onSupportTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9B208),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFF00C9A7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(
                Icons.sports_tennis,
                color: Color(0xFF1E3A8A),
                size: 32,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Join our mission to make playing sports easier for all.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onSupportTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF274FED),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size(0, 34),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'SUPPORT RECLUB',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
