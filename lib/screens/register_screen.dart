import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Daftar Akun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            
            CustomTextField(
              labelText: 'Nama Lengkap',
              prefixIcon: Icons.person,
              controller: _nameController, 
            ),
            const SizedBox(height: 20),

            CustomTextField(
              labelText: 'Email',
              prefixIcon: Icons.email,
              controller: _emailController, 
            ),
            const SizedBox(height: 20),

            CustomTextField(
              labelText: 'Password',
              prefixIcon: Icons.lock,
              obscureText: true,
              controller: _passwordController, 
            ),
            const SizedBox(height: 30),

            // Ini Untuk Tombol Daftar
           PrimaryButton(
             text: 'Daftar',
             onPressed: () {
              // Nanti logika validasi atau aksi daftar dimasukkan ke sini
             },
           ), 
          ],
        ),
      ),
    );
  }
} 