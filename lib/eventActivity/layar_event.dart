import 'package:flutter/material.dart';

class LayarEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Jadwal & Event",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber, 
      ),
      
      body: Column(
        children: [
          SizedBox(height: 20), 
          Center(
            child: Text(
              "tes",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}