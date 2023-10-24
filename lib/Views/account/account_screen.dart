// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Splash_screen/SplashScreen.dart';
import 'package:flutter_application_1/utils/saveimg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Services/user_auth.dart';
import '../../utils/image_picker.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
Uint8List? _image;
  Future<void> _pickImage() async {
    Uint8List img= await pickimg(ImageSource.gallery);
    setState(() {
      _image=img;
    });
}


  final Authservice auth = Authservice();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  late User? _currentUser;
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _currentUser = _auth.currentUser;
    setState(() {});
  }

  void savedata() async{
    String resp= await saveimg().saveData(file: _image!);

  }

  @override
  Widget build(BuildContext context) {
        final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 251, 236, 105),
        title: Text('Profile'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 251, 236, 105),
              Colors.white,
            ], // Add your desired colors here
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
            stream: _users.doc(_currentUser?.uid).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                final DocumentSnapshot document = streamSnapshot.data!;

                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 80,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : CircleAvatar(
                                    radius: 80,
                                    backgroundImage: NetworkImage(
                                        'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg'),
                                  ),
                            Positioned(
                              right: 0,
                              bottom: 2.0,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage();
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(document['firstname']),
                      Text(document['email']),
                      GestureDetector(
                        onTap: savedata,
                        child: Text('SAVE IMG')),
                      SizedBox(height: 20),
                      ListTile(
                        leading: Icon(
                          Icons.shopping_cart,
                        ),
                        title: Text('My Orders'),
                        onTap: () {
                          // Navigate to the orders page
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.favorite),
                        title: Text('My Wishlist'),
                        onTap: () {
                          // Navigate to the wishlist page
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () {
                          // Navigate to the wishlist page
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        onTap: () {
                          auth.signOut();
                          Get.offAll(SplashScreen());
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
