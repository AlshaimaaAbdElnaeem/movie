import 'package:flutter/material.dart';
import 'package:movie/features/Auth/signin.dart';
import 'package:movie/features/Auth/signup.dart';

class MyDetailsPage extends StatelessWidget {
  const MyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please sign in or create an account to access your profile and wishlist.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInPage()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text('Sign In', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpPage()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text('Sign Up', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
