// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '/daftarClub/ClubDetail.dart';
import '../daftarClub/AddNewClub.dart';
import '../widgets/club_card.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/profile_header.dart';
import '../daftarClub/ClubRepository.dart';
import '../Models/Club.dart';

// Halaman utama yang menampung Navigation Bar
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeContentPage(),
    ExploreClubsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Jelajah'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

// 1. Tampilan Isi Beranda (Home Content) -- TIDAK DIUBAH
class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReClub Beranda', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang di ReClub!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Temukan berbagai komunitas seru di sekitarmu.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 25),
            const Text(
              'Klub Populer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  ClubCard(
                    title: 'Klub Belajar Flutter',
                    subtitle: 'Diskusi dan ngoding bareng setiap minggu.',
                    iconData: Icons.group,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClubDetail(
                            title: 'Klub Belajar Flutter',
                            subtitle: 'Diskusi dan ngoding bareng setiap minggu.',
                            iconData: '💻',
                            members: 42,
                            description:
                                'Klub ini terbuka untuk semua mahasiswa yang ingin belajar Flutter bareng, '
                                'dari basic sampai bikin aplikasi nyata. Ada sesi ngoding bareng tiap minggu.',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  ClubCard(
                    title: 'Klub Game & Esport',
                    subtitle: 'Mabar seru dan turnamen internal.',
                    iconData: Icons.sports_esports,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClubDetail(
                            title: 'Klub Game & Esport',
                            subtitle: 'Mabar seru dan turnamen internal.',
                            iconData: '🎮',
                            members: 87,
                            description:
                                'Wadah buat kamu yang suka gaming, mulai dari mobile legends sampai valorant. '
                                'Ada turnamen internal rutin dengan hadiah menarik.',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Tampilan Halaman Jelajah (Explore)
class ExploreClubsPage extends StatefulWidget {
  const ExploreClubsPage({super.key});

  @override
  State<ExploreClubsPage> createState() => _ExploreClubsPageState();
}

class _ExploreClubsPageState extends State<ExploreClubsPage> {
  String _searchQuery = '';

  void _tambahClub() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NambahClub()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelajah Klub', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahClub,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomSearchBar(
              hintText: 'Cari komunitas impianmu...',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ValueListenableBuilder<List<Club>>(
                valueListenable: ClubRepository.instance.clubs,
                builder: (context, clubList, _) {
                  final filtered = clubList
                      .where((club) =>
                          club.namaClub.toLowerCase().contains(_searchQuery))
                      .toList();

                  if (filtered.isEmpty) {
                    return const Center(child: Text('Klub tidak ditemukan'));
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      final club = filtered[index];
                      return ClubCard(
                        title: club.namaClub,
                        subtitle: club.deskripsiClub,
                        iconData: Icons.groups,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClubDetail(
                                title: club.namaClub,
                                subtitle: club.deskripsiClub,
                                iconData: '👥',
                                members: club.members,
                                description: club.deskripsiClub,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Tampilan Halaman Profil (Profile)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Keluar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileHeader(name: 'Diana', email: 'diana@student.untar.ac.id'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Keluar Akun', style: TextStyle(fontSize: 16)),
                onPressed: () => _showLogoutDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}