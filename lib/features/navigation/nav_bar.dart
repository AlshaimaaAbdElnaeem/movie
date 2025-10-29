import 'package:flutter/material.dart';
import 'package:movie/features/home/presentation/home_screen.dart';
import 'package:movie/features/profile/user_profile.dart';
import 'package:movie/features/wishlist/wishlist_screen.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int currentIndex = 0;
  List screen = [
    const MyHomePage(), const MyWishList(), const MyProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFCD3E10),
            elevation: 5.0,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 30.0,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 25.0,
            ),
            showSelectedLabels: false,
            showUnselectedLabels: false,

            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: "Wishlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
      body: screen[currentIndex],
    );
  }
}
