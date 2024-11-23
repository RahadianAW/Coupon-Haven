import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  // final ImagePicker _picker = ImagePicker();

  late Map<String, String> userDetails = {};

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  // Fungsi untuk memuat detail pengguna dari SharedPreferences
  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
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

  // Fungsi untuk memilih gambar profil
  // Future<void> _pickImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(
  //     source: ImageSource.gallery, // Bisa diganti dengan ImageSource.camera
  //     maxWidth: 400,
  //     maxHeight: 400,
  //     imageQuality: 85,
  //   );

  //   if (pickedFile != null) {
  //     setState(() {
  //       _profileImage = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: userDetails.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  GestureDetector(
                    // onTap: _pickImage, // Ketika gambar di-tap, pilih gambar
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
                ],
              ),
            ),
    );
  }
}
