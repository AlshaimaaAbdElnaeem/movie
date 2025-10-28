import 'package:flutter/material.dart';

class MyDetailsPage extends StatelessWidget {
  const MyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Details Page'),
      ),
      body: const Center(
        child: Text('This is movie details page'),
      ),
    );
  }
}