import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sherophopia/DoctorTabs/UploadTab.dart';

class UploadResume extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<UploadResume> createState() => _UploadResumeState();
}

class _UploadResumeState extends State<UploadResume> {
  String enteredName = '';
  String enteredBio = '';
  final _formKey = GlobalKey<FormState>();

  Future<String?> getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['username'] as String?;
      }
    }
    return null;
  }

  Future<void> _saveBio() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final username = await getUsername();
      if (username != null) {
        await FirebaseFirestore.instance.collection('users').doc(username).set({
          'bio': enteredBio,
        }, SetOptions(merge: true));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bio saved successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username not found')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not signed in')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Resume'),
        backgroundColor: Color.fromRGBO(72, 132, 151, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Please Enter Your Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
                onChanged: (value) {
                  setState(() {
                    enteredName = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Please Enter Your Bio',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
                onChanged: (value) {
                  setState(() {
                    enteredBio = value;
                  });
                },
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (enteredName.isNotEmpty && enteredBio.isNotEmpty) {
                    _saveBio(); // Save bio if name and bio are not empty
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadTab(userName: enteredName, bio: enteredBio)),
                    );
                  } else {
                    // Notify the user to enter both name and bio
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter both name and bio'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(72, 132, 151, 1),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
