import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  late Map<String, String> userDetails = {};
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedInUsername');
    if (username != null && username.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
        userDetails = {
          'username': prefs.getString('loggedInUsername') ?? 'Unknown User',
          'firstName': prefs.getString('firstName') ?? '-',
          'lastName': prefs.getString('lastName') ?? '-',
          'gender': prefs.getString('gender') ?? '-',
          'phone': prefs.getString('phone') ?? '-',
          'address': prefs.getString('address') ?? '-',
        };
      });
    }
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      isLoggedIn = false;
      userDetails = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: isLoggedIn
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userDetails['username'] ?? 'Unknown User',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ListTile(
                    title: const Text('Nama Depan'),
                    subtitle: Text(userDetails['firstName'] ?? '-'),
                  ),
                  ListTile(
                    title: const Text('Nama Belakang'),
                    subtitle: Text(userDetails['lastName'] ?? '-'),
                  ),
                  ListTile(
                    title: const Text('Jenis Kelamin'),
                    subtitle: Text(userDetails['gender'] ?? '-'),
                  ),
                  ListTile(
                    title: const Text('Nomor HP'),
                    subtitle: Text(userDetails['phone'] ?? '-'),
                  ),
                  ListTile(
                    title: const Text('Alamat'),
                    subtitle: Text(userDetails['address'] ?? '-'),
                  ),
                  ElevatedButton(
                    onPressed: _logout,
                    child: const Text('Logout'),
                  ),
                ],
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  ).then((_) {
                    // Refresh profile page after login
                    _checkLoginStatus();
                  });
                },
                child: const Text('Login to your account'),
              ),
            ),
    );
  }
}
