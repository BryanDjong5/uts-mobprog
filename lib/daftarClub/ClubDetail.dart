// daftarClub/ClubDetail.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ClubRepository.dart';

class ClubDetail extends StatefulWidget {
  final String? clubId;
  final String title;
  final String subtitle;
  final String iconData;
  final int members;
  final String description;
  final String? fotoPath;
  final bool isJoined;

  const ClubDetail({
    super.key,
    this.clubId,
    required this.title,
    required this.subtitle,
    required this.iconData,
    this.members = 0,
    this.description = '',
    this.fotoPath,
    this.isJoined = false,
  });

  @override
  State<ClubDetail> createState() => _ClubDetailPage();
}

class _ClubDetailPage extends State<ClubDetail> {
  late bool isJoined;
  late int members;
  File? foto;
  final ImagePicker picker = ImagePicker();

  static final Map<String, bool> _joinSaved = {};
  static final Map<String, int> _memberSaved = {};
  static final Map<String, String?> _fotoSaved = {};

  String get _kunci => widget.clubId ?? widget.title;

  @override
  void initState() {
    super.initState();
    isJoined = _joinSaved[_kunci] ?? widget.isJoined;
    members = _memberSaved[_kunci] ?? widget.members;

    final fotoPath = _fotoSaved.containsKey(_kunci)
        ? _fotoSaved[_kunci]
        : widget.fotoPath;
    if (fotoPath != null) {
      final file = File(fotoPath);
      if (file.existsSync()) foto = file;
    }
  }

  void _toggleIsJoined() {
    setState(() {
      isJoined = !isJoined;
      members += isJoined ? 1 : -1;
    });

    _joinSaved[_kunci] = isJoined;
    _memberSaved[_kunci] = members;

    if (widget.clubId != null) {
      ClubRepository.instance.updateJoin(widget.clubId!, isJoined, members);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isJoined
              ? 'Anda berhasil join ${widget.title}!'
              : 'Anda keluar dari ${widget.title}.',
        ),
      ),
    );
  }

  void _simpanFoto(File? file) {
    setState(() => foto = file);
    _fotoSaved[_kunci] = file?.path;
    if (widget.clubId != null) {
      ClubRepository.instance.updateFoto(widget.clubId!, file?.path);
    }
  }

  Future<void> _pilihFoto(ImageSource source) async {
    final picked = await picker.pickImage(
      source: source,
      maxWidth: 800,
      imageQuality: 80,
    );
    if (picked == null) return;

    _simpanFoto(File(picked.path));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Foto club berhasil diganti')),
    );
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
                title: const Text('Hapus Foto',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(ctx);
                  _simpanFoto(null);
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 0, 65, 150),
      ),
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: foto != null ? FileImage(foto!) : null,
                      child: foto == null
                          ? Text(widget.iconData,
                              style: const TextStyle(fontSize: 40))
                          : null,
                    ),
                    if (isJoined)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _tampilkanPilihanFoto,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 25),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 6),
                color: theme.colorScheme.primaryContainer.withOpacity(0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.groups_rounded,
                            color: theme.colorScheme.primary, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jumlah Member',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                          scale: animation, child: child),
                                  child: Text(
                                    '$members',
                                    key: ValueKey<int>(members),
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text('anggota',
                                    style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isJoined)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Bergabung',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tentang Club',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description.isEmpty
                    ? widget.subtitle
                    : widget.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 25),
              if (isJoined) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade100,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        'Anda sudah bergabung dengan club ini',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _tampilkanPilihanFoto,
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: const Text('Ganti Foto Club'),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _toggleIsJoined,
                  icon: Icon(isJoined ? Icons.exit_to_app : Icons.group_add),
                  label: Text(isJoined ? 'Leave Club' : 'Join Club'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}