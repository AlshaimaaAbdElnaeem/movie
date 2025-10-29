import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie/features/Auth/signin.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? userName;
  String? userEmail;
  String? userProfileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      userEmail = prefs.getString('user_email');
      userProfileImage = prefs.getString('user_profile_image');
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_profile_image');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF121212),
      ),
      body: userName == null || userEmail == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: userProfileImage != null
                            ? NetworkImage(userProfileImage!)
                            : const AssetImage('assets/images/user_avatar.png')
                                as ImageProvider,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userName ?? 'No name available',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userEmail ?? 'No email available',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCD3E10),
                        ),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
