import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'components/profile_avatar.dart';
import 'components/profile_bio_section.dart';
import 'components/sport_item.dart';
import 'components/sports_section_header.dart';
import 'components/support_banner.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ==========================================
  // STATE DATA PROFIL
  // ==========================================
  String displayName = 'van';
  String username = '@van-541';
  File? profileImageFile;
  String genderAge = 'Add gender and age group';
  String bio = 'Tell us a little bit about yourself';

  // Master Data Pilihan
  final List<String> availableSports = [
    'Badminton',
    'Basketball',
    'Tennis',
    'Padel',
    'Volleyball',
    'Soccer',
    'Swimming',
    'Table Tennis',
    'Running',
  ];

  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  final List<String> ageGroupOptions = [
    'Junior (under 18)',
    'Adult (18-55)',
    'Senior (above 55)',
  ];

  // List Cabang Olahraga
  List<Map<String, String>> sportsList = [
    {'name': 'Badminton', 'level': 'Intermediate'},
  ];

  // ==========================================
  // FUNGSI INTERAKTIF & DIALOG
  // ==========================================

  // 1. Ambil Foto dari Galeri
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profileImageFile = File(image.path);
      });
    }
  }

  // Bottom Sheet Ubah Foto Profil
  void _showEditPhotoBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ubah Foto Profil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFF274FED),
                ),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              if (profileImageFile != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Hapus Foto Profil',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    setState(() {
                      profileImageFile = null;
                    });
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // 2. Dialog Edit Name & Username
  void _showEditNameAndUsernameDialog() {
    final nameController = TextEditingController(text: displayName);
    final usernameController = TextEditingController(text: username);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isNotEmpty &&
                    usernameController.text.trim().isNotEmpty) {
                  setState(() {
                    displayName = nameController.text.trim();
                    username = usernameController.text.trim().startsWith('@')
                        ? usernameController.text.trim()
                        : '@${usernameController.text.trim()}';
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // 3. Dialog Pilihan Gender & Age Group
  void _showEditGenderAgeDialog() {
    String selectedGender = genderOptions.first;
    String selectedAgeGroup = ageGroupOptions[1]; // Default: Adult (18-55)

    if (genderAge.contains(',')) {
      final parts = genderAge.split(',');
      if (parts.length >= 2) {
        final existingGender = parts[0].trim();
        final existingAge = parts[1].trim();

        if (genderOptions.contains(existingGender)) {
          selectedGender = existingGender;
        }
        if (ageGroupOptions.contains(existingAge)) {
          selectedAgeGroup = existingAge;
        }
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Gender & Age Group'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedGender,
                    items: genderOptions
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => selectedGender = val);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Age Group',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedAgeGroup,
                    items: ageGroupOptions
                        .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => selectedAgeGroup = val);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      genderAge = '$selectedGender, $selectedAgeGroup';
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 4. Dialog Edit Bio
  void _showEditBioDialog() {
    final controller = TextEditingController(
      text: bio == 'Tell us a little bit about yourself' ? '' : bio,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Bio'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Tulis cerita singkat tentang dirimu...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    bio = controller.text.trim();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // 5. Bottom Sheet Pilihan Olahraga
  void _showAddSportBottomSheet() {
    String selectedSport = availableSports.first;
    String selectedLevel = 'Beginner';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tambah Olahraga',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Pilih Olahraga:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedSport,
                    items: availableSports
                        .map(
                          (sport) => DropdownMenuItem(
                            value: sport,
                            child: Text(sport),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() => selectedSport = val);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tingkat Kemampuan:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedLevel,
                    items: ['Beginner', 'Intermediate', 'Advanced', 'Pro']
                        .map(
                          (level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() => selectedLevel = val);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF274FED),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        setState(() {
                          sportsList.add({
                            'name': selectedSport,
                            'level': selectedLevel,
                          });
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Tambahkan',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 6. Options Bottom Sheet Hapus Olahraga
  void _showSportOptions(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                sportsList[index]['name']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Hapus Olahraga',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  setState(() {
                    sportsList.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getInitials(String name) {
    if (name.trim().isEmpty) return 'VA';
    List<String> parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  // ==========================================
  // BUILD METHOD UTAMA
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              ProfileAvatar(
                initials: _getInitials(displayName),
                imageFile: profileImageFile,
                onTap: _showEditPhotoBottomSheet,
              ),
              const SizedBox(height: 12),

              ProfileBioSection(
                displayName: displayName,
                username: username,
                genderAgePlaceholder: genderAge,
                bioPlaceholder: bio,
                onNameTap: _showEditNameAndUsernameDialog,
                onGenderAgeTap: _showEditGenderAgeDialog,
                onBioTap: _showEditBioDialog,
              ),
              const SizedBox(height: 24),

              SupportBanner(
                onSupportTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terima kasih telah mendukung Reclub! 🎉'),
                      backgroundColor: Color(0xFF274FED),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              SportsSectionHeader(onAddSportTap: _showAddSportBottomSheet),
              const SizedBox(height: 12),

              sportsList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Belum ada olahraga ditambahkan',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sportsList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final sport = sportsList[index];
                        return SportItemCard(
                          sportName: sport['name']!,
                          skillLevel: sport['level']!,
                          onTap: () => _showSportOptions(index),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
