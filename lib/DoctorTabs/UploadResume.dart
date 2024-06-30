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

  String? userName; // Variable to store user's username

  @override
  void initState() {
    super.initState();
    // Initialize user's username in initState
    getUserData();
  }

  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final username = user.displayName; // Assuming displayName is set as the username
        if (username != null && username.isNotEmpty) {
          setState(() {
            userName = username;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username not found')),
          );
        }
      } catch (e) {
        print('Error fetching username: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch username')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not signed in')),
      );
    }
  }

  Future<void> _saveBio() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final username = user.displayName; // Assuming displayName is set as the username
      if (username != null && username.isNotEmpty) {
        if (enteredName.isNotEmpty && enteredBio.isNotEmpty) {
          try {
            // Update the document with the username
            await FirebaseFirestore.instance.collection('users').doc(username).set({
              'bio': enteredBio,
            }, SetOptions(merge: true)); // Use merge: true to merge with existing data

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Bio saved successfully')),
            );

            // Navigate to next screen only after bio is saved
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadTab(userName: enteredName, bio: enteredBio)),
            );
          } catch (e) {
            print('Error saving bio: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save bio')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter both name and bio')),
          );
        }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Upload Resume", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
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
                  if (_formKey.currentState!.validate()) {
                    _saveBio(); // Save bio if form is valid
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
