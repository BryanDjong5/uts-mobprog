import 'package:flutter/material.dart';

class ProfileBioSection extends StatelessWidget {
  final String name;
  final String username;
  final String genderAge;
  final String bio;

  const ProfileBioSection({
    super.key,
    required this.name,
    required this.username,
    required this.genderAge,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          username,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Text(
          genderAge,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Text(bio, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
