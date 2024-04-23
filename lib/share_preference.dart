import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrence extends StatefulWidget {
  const SharedPrefrence({super.key});

  @override
  State<SharedPrefrence> createState() =>
      _SharedPrefrenceState();
}

class _SharedPrefrenceState extends State<SharedPrefrence> {
  var nameController = TextEditingController();
  String usernName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListTile(
          title: Text(usernName),
          leading: IconButton(
              onPressed: () {
                showTextDialog();
              },
              icon: Icon(Icons.edit)),
        ),
      ),
    );
  }

  showTextDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextFormField(
            controller: nameController,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  saveData('personName', nameController.text);
                  loadValues();
                  Navigator.pop(context);
                },
                child: Text("save")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("cancel"))
          ],
        );
      },
    );
  }

  saveData(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  getData(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  loadValues() async {
    final savedName = await getData('personName');
    setState(() {
      usernName = savedName;
    });
  }
}
