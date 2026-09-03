import 'package:flutter/material.dart';
import 'package:uts_mobprog/ListClub.dart';

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
      home: const ListClub(),
    );
  }
}


