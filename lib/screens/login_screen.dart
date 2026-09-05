import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            const Text(
              'ReClub',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue, 
              ),
            ),
            const SizedBox(height: 40), 

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
              text: 'Masuk',
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email dan Password tidak boleh kosong!'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                   ),
                 );
              } else {
                  Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                       builder: (context) => const HomeScreen(),
        ),
      );
    }
  },
),
            const SizedBox(height: 15),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text(
                'Belum punya akun? Daftar di sini',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}