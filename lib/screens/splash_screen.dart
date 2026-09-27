import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Sesuaikan dengan nama file login kamu jika berbeda

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Mengatur durasi intro (misalnya 3 detik) sebelum pindah ke Login
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna navy andalan kita (0xFF2B2D42)
      backgroundColor: const Color(0xFF2B2D42),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo atau Ikon Aplikasi di tengah
            const Icon(
              Icons.sports_esports, 
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            // Nama Aplikasi / Teks Intro
            const Text(
              'Reclub',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kelola Komunitasmu dengan Mudah',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}