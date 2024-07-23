// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:fake_store/authentication/data/models/user_model.dart';
import 'package:fake_store/authentication/data/repositeries/auth_repositery.dart';
import 'package:fake_store/authentication/presentation/screens/login_screen.dart';
import 'package:fake_store/authentication/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userData;
  const ProfileScreen({super.key, required this.userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imgFile;
  File? _imgFileCover;

  void takeProfilePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery, // alternatively, use ImageSource.gallery
      maxWidth: 400,
    );
    if (img == null) return;
    setState(() {
      AuthRepositery.saveImageProfile(img.path);
      _imgFile = File(img.path); // convert it to a Dart:io file
    });
  }

  checkImage() {
    String? img = AuthRepositery.getImageProfile();
    if (img == null) {
      return;
    }
    setState(() {
      _imgFile = File(img);
    });
  }

  void takeCoverPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? cover = await picker.pickImage(
      source: ImageSource.gallery, // alternatively, use ImageSource.gallery
      maxWidth: 400,
    );
    if (cover == null) return;
    setState(() {
      AuthRepositery.saveCoverPhoto(cover.path);
      _imgFileCover = File(cover.path); // convert it to a Dart:io file
    });
  }

  checkCoverImage() {
    String? cover = AuthRepositery.getCoverPhoto();
    if (cover == null) {
      return;
    }
    setState(() {
      _imgFileCover = File(cover);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkImage();
    checkCoverImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        actions: [
          IconButton(
              onPressed: () {
                AuthRepositery.deleteAccount();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return SignupScreen();
                }), (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.delete)),
          Text('Logout'),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: takeCoverPhoto,
                  child: (_imgFileCover == null)
                      ? Image.network(
                          "https://marketplace.canva.com/EAFGOWcdqcc/1/0/1600w/canva-blue-and-orange-watercolor-flowers-inspirational-facebook-cover-wMPA3VGxSiI.jpg",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Image.file(_imgFileCover!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: -70,
                  child: InkWell(
                    onTap: takeProfilePhoto,
                    child: CircleAvatar(
                        radius: 75,
                        backgroundImage: (_imgFile == null)
                            ? NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9tu0c_cjxMIIll3_E23_TRiAGPLXAW5WJFg&s')
                            : FileImage(_imgFile!)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              widget.userData.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              widget.userData.email,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
            ),
            Text(
              widget.userData.phone,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
