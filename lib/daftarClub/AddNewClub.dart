// daftarClub/AddNewClub.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? foto;
  final ImagePicker picker = ImagePicker();

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
      fotoPath: foto?.path, 
    );

    ClubRepository.instance.addClub(clubBaru);
    Navigator.pop(context);
  }

  Future<void> _pilihFoto(ImageSource source) async {
    final picked = await picker.pickImage(
      source: source,
      maxWidth: 800,
      imageQuality: 80,
    );
    if (picked == null) return;
    setState(() => foto = File(picked.path));
  }

  void _tampilkanPilihanFoto() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(ctx);
                _pilihFoto(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Ambil dari Kamera'),
              onTap: () {
                Navigator.pop(ctx);
                _pilihFoto(ImageSource.camera);
              },
            ),
            if (foto != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Hapus Foto',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  setState(() => foto = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  InputDecoration bagusinTampilan({
    required ThemeData theme,
    required String label,
    required String hint,
    required IconData icon,
  }) {
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
    final theme = Theme.of(context).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 0, 67, 150),
      ),
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Club')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                const SizedBox(height: 24),

                // Kolom foto (opsional)
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _tampilkanPilihanFoto,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  theme.colorScheme.primary.withOpacity(0.12),
                              backgroundImage:
                                  foto != null ? FileImage(foto!) : null,
                              child: foto == null
                                  ? Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 32,
                                      color: theme.colorScheme.primary,
                                    )
                                  : null,
                            ),
                            if (foto != null)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.colorScheme.surface,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        foto == null
                            ? 'Foto Club (opsional)'
                            : 'Ketuk untuk ganti foto',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                TextField(
                  controller: namaClub,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: bagusinTampilan(
                    theme: theme,
                    label: 'Nama Club',
                    hint: 'Isi nama klub yang anda inginkan',
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
                    theme: theme,
                    label: 'Deskripsi',
                    hint: 'Ceritakan tentang club ini...',
                    icon: Icons.description_outlined,
                  ).copyWith(
                    alignLabelWithHint: true,
                    prefixIcon: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Icon(Icons.description_outlined),
                        ),
                      ],
                    ),
                  ),
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