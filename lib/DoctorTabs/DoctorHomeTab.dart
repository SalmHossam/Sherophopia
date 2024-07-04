import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'set_appointments.dart'; // Import the new file

class DoctorHomeTab extends StatefulWidget {
  const DoctorHomeTab({super.key});

  @override
  State<DoctorHomeTab> createState() => _DoctorHomeTabState();
}

class _DoctorHomeTabState extends State<DoctorHomeTab> {
  User? user;
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        username = user!.displayName ?? user!.email!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage:
                AssetImage('assets/images/profile.jpg'), // Provide image path
              ),
              SizedBox(width: 10), // Add spacing between avatar and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Text("DR: "),
                      Text(username,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SetAppointments()),
              );
            },
            child: Text('Set Available Appointments'),
          ),
        ],
      ),
    );
  }
}
