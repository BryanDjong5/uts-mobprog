import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'daftarClub/ListClub.dart';
import 'daftarClub/AddNewClub.dart';

void main() {
  runApp(const Reclub());
}

class Reclub extends StatelessWidget {
  const Reclub({super.key});

  @override
  Widget build(BuildContext context) {
    // const dihapus dari MaterialApp agar tema bisa dimasukkan
    return MaterialApp(
      title: 'Reclub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B2D42)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2B2D42),
          foregroundColor: Colors.white, 
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF2B2D42),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    ); 
  }
}