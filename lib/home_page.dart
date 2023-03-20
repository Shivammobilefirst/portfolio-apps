import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_porfolio/change_images.dart';
import './edit_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? name;
  String? email;
  String? bio;
  String? newImage;

  @override
  void initState() {
    pref();
    updateImage();
  }

  void updateImage() async {
    var prefs = await SharedPreferences.getInstance();
    newImage = prefs.getString("Simage");
    print(newImage);
    setState(() {});
  }

  void upDateId(String names, String emails, String bios) {
    setState(() {
      name = names;
      email = emails;
      bio = bios;
    });
  }

  void pref() async {
    var prefs = await SharedPreferences.getInstance();
    name = prefs.getString("Sname");
    email = prefs.getString("Semailid");
    bio = prefs.getString("Sbio");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portfolios"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Portfolio App'),
            ),
            ListTile(
              title: const Text('Change Images'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChangeScreen();
                }));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            newImage == null
                ? Image.asset(
                    "images/porfolio.jpeg",
                    width: 200.0,
                    height: 200.0,
                  )
                : Image.file(
                    File(newImage!),
                    width: 200.0,
                    height: 200.0,
                  ),
            SizedBox(
              height: 20,
            ),
            Text("$name"),
            Text("$email"),
            Text("$bio"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditPage(
                  textChanged: (String names, String emails, String bios) {
                    upDateId(names, emails, bios);
                  },
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
