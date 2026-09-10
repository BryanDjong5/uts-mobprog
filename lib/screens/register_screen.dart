import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../user_data.dart'; // Jangan lupa import file data ini!

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
            PrimaryButton(
              text: 'Daftar',
              onPressed: () {
                String nama = _nameController.text.trim();
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                // Validasi: Cek apakah ada satu saja yang kosong
                if (nama.isEmpty || email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama Lengkap, Email, dan Password wajib diisi!'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  bool isExist = AppData.registeredUsers.any((user) => user.email == email);

                  if (isExist) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email sudah terdaftar! Silakan login.'),
                        backgroundColor: Colors.orange,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // Catatan: Pastikan class UserAccount kamu juga mendukung parameter 'nama' jika ingin disimpan
                    AppData.registeredUsers.add(UserAccount(email: email, password: password));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registrasi Berhasil! Silakan Masuk.'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}