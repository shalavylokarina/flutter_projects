import 'dart:async';
import 'dart:io';
// ignore: unnecessary_import
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab2/repository/local_storage_repository.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final LocalStorageRepository _localStorageRepository = LocalStorageRepository();
  Uint8List? profileImageBytes;
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userInfo = await _localStorageRepository.getUserInfo();
    final imagePath = await _localStorageRepository.getProfileImagePath();

    setState(() {
      _usernameController.text = userInfo['username'] ?? '';
      profileImagePath = imagePath;

      if (kIsWeb && profileImagePath != null) {
        // Завантажуємо зображення для веб
        _loadImageAsBytes(profileImagePath!);
      } else {
        profileImageBytes = null; // Не використовуємо bytes для мобільних
      }
    });
  }

  Future<void> _loadImageAsBytes(String path) async {
    final bytes = await File(path).readAsBytes();
    setState(() {
      profileImageBytes = bytes;
    });
  }

  Future<void> _pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      if (kIsWeb) {
        // Для веба - використовуємо bytes
        setState(() {
          profileImageBytes = result.files.single.bytes;
        });
      } else {
        // Для мобільних платформ використовуємо шлях до файлу
        String? path = result.files.single.path;
        if (path != null) {
          setState(() {
            profileImagePath = path;
          });
          await _localStorageRepository.saveProfileImagePath(path);
        }
      }
    }
  }

  // ignore: unused_element
  Future<void> _saveProfile() async {
    await _localStorageRepository.saveRegistrationData(
      _usernameController.text,
      (await _localStorageRepository.getUserInfo())['email'] ?? '',
      (await _localStorageRepository.getRegistrationData())['password'] ?? '',
    );

    // Зберігаємо шлях до зображення
    if (profileImagePath != null) {
      await _localStorageRepository.saveProfileImagePath(profileImagePath!);
    }
     setState(() {});
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileImageBytes != null
                    ? MemoryImage(profileImageBytes!)
                    : profileImagePath != null
                        ? FileImage(File(profileImagePath!))
                        : null,
                backgroundColor: Colors.grey,
                child: profileImageBytes == null && profileImagePath == null
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
              if (profileImagePath != null) {
               await _localStorageRepository.saveProfileImagePath(profileImagePath!);
       }
               // ignore: use_build_context_synchronously
               Navigator.pop(context); // Повертаємося до профілю після збереження
  },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
