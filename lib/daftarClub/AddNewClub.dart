// daftarClub/AddNewClub.dart
import 'package:flutter/material.dart';
import '../Models/Club.dart';
import '/daftarClub/ClubRepository.dart';

class NambahClub extends StatefulWidget {
  const NambahClub({super.key});

  @override
  State<NambahClub> createState() => _NambahClubState();
}

class _NambahClubState extends State<NambahClub> {
  final TextEditingController namaClub = TextEditingController();
  final TextEditingController deskripsiClub = TextEditingController();

  void createClub() {
    final clubname = namaClub.text.trim();
    final clubdesc = deskripsiClub.text.trim();

    if (clubname.isEmpty || clubdesc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Nama dan deskripsi harus diisi'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      );
      return;
    }

    final clubBaru = Club(
      namaClub: clubname,
      deskripsiClub: clubdesc,
      members: 1,
      isJoined: true,
    );

    ClubRepository.instance.addClub(clubBaru);
    Navigator.pop(context);
  }

  InputDecoration bagusinTampilan({
    required BuildContext context,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.25),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Club')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.group_add_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Buat Club Baru',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'Isi detail club kamu, lalu ajak teman bergabung.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              TextField(
                controller: namaClub,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: bagusinTampilan(
                  context: context,
                  label: 'Nama Club',
                  hint: 'Contoh: Klub Fotografi',
                  icon: Icons.badge_outlined,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: deskripsiClub,
                maxLines: 5,
                maxLength: 200,
                textCapitalization: TextCapitalization.sentences,
                decoration: bagusinTampilan(
                  context: context,
                  label: 'Deskripsi',
                  hint: 'Ceritakan tentang club ini...',
                  icon: Icons.description_outlined,
                ).copyWith(alignLabelWithHint: true),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: createClub,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text(
                    'Create Club',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaClub.dispose();
    deskripsiClub.dispose();
    super.dispose();
  }
}