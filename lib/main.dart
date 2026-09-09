import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:uts_mobprog/daftarClub/ListClub.dart';
import 'package:uts_mobprog/daftarClub/AddNewClub.dart';

void main() {
  runApp(const Reclub());
}

class Reclub extends StatelessWidget {
  const Reclub({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reclub',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}