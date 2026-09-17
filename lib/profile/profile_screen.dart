import 'package:flutter/material.dart';

import 'components/profile_avatar.dart';
import 'components/profile_bio_section.dart';
import 'components/sports_section_header.dart';
import 'components/sport_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 20),
            ProfileAvatar(initials: 'VA'),
            SizedBox(height: 16),
            ProfileBioSection(
              name: 'van',
              username: '@van-541',
              genderAge: '⚥ Add gender and age group',
              bio: 'Tell us little bit about yourslef',
            ),
            SizedBox(height: 24),
            Divider(color: Colors.grey, thickness: 0.5),
            SizedBox(height: 16),
            SportsSectionHeader(),
            SizedBox(height: 16),
            Row(
              children: [
                SportItem(sportName: 'Badminton'),
                SizedBox(width: 8),
                SportItem(sportName: 'Running'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
