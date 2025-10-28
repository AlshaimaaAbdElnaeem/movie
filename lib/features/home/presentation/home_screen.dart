import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
          child: ClipOval(
            child: Image.asset(
              'assets/images/user_avatar.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            "Hello User",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: const Text(
            "Enjoy your favorite movies",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, size: 28),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(70, 69, 69, 1),
                hintText: 'Search Movie...',
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Popular Movies",
                style: TextStyle(fontSize: 20),
                // textAlign: TextAlign.left,
              ),
            ),
            card()
          ],
        ),
      ),
    );
  }
}

Widget card () {
  return Container(
    width: 150,
    height: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      image: const DecorationImage(
        image: AssetImage('assets/images/movie_poster.png'),
        fit: BoxFit.cover,
      ),
    ),
  );
}