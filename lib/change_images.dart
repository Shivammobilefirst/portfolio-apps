import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_porfolio/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void imageCallBack(Image image);

class ChangeScreen extends StatefulWidget {
  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  File? image;
  File? galleryImage;
  void pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      final imageTemporary = File(image!.path);
      setState(() async {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString("Simage", image.path);
        this.image = imageTemporary;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
            (route) => false);
      });
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
  }

  void openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);
      setState(() async {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString("Simage", image.path);
        this.image = imageTemporary;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
            (route) => false);
      });
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Image"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                return pickImage();
              },
              child: Text("Open Camera"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                return openGallery();
              },
              child: Text("Open Gallery")),
        ],
      ),
    );
  }
}
