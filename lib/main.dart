import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:uts_mobprog/daftarClub/ListClub.dart';
import 'package:uts_mobprog/daftarClub/AddNewClub.dart';
import 'package:uts_mobprog/eventActivity/layar_event.dart';

void main() {
  runApp(const Reclub());
}

class Reclub extends StatelessWidget {
  const Reclub({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reclub',
<<<<<<< HEAD
      home: LayarEvent(),
=======
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
>>>>>>> bec4e86c5d69660cd7e5aa4dec83573a139fc560
    );
  }
}
