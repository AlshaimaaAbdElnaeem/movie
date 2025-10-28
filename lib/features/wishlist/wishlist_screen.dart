import 'package:flutter/material.dart';

class MyWishList extends StatelessWidget {
  const MyWishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wish List'),
      ),
      body: const Center(
        child: Text('No items in your wish list')
      ),
    );
  }
}