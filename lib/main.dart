import 'package:flutter/material.dart';
import 'package:uts_mobprog/daftarClub/ListClub.dart';
import 'package:uts_mobprog/daftarClub/AddNewClub.dart';
import 'package:uts_mobprog/eventActivity/layar_event.dart';

void main() {
  runApp(const Reclub());
}

class Reclub extends StatelessWidget {
  const Reclub({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reclub',
      home: LayarEvent(),
    );
  }
}


