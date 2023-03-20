import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void IntCallback(String name, String mail, String bio);

class EditPage extends StatelessWidget {
  @override
  final IntCallback textChanged;
  EditPage({required this.textChanged});

  String? newnames;
  String? newemailid;
  String? newbio;

  var name = TextEditingController();

  var email = TextEditingController();

  var descrip = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Details"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter E-mail',
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: descrip,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter short description'),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                ),
                SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String newnames = name.text.toString();
                    String newemailid = email.text.toString();
                    String newbio = descrip.text.toString();

                    textChanged(newnames, newemailid, newbio);
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString("Sname", newnames);
                    prefs.setString("Semailid", newemailid);
                    prefs.setString("Sbio", newbio);

                    Navigator.pop(context);
                  },
                  child: Text("Updates details"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
