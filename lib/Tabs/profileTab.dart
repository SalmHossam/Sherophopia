import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  void _saveProfileData() {
    // Check if any of the required fields are empty
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _bioController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    // Create a document with email as the document ID
    FirebaseFirestore.instance
        .collection('profiles')
        .doc(_emailController.text) // Use email as document ID
        .set({
      'name': _nameController.text,
      'email': _emailController.text,
      'address': _addressController.text,
      'bio': _bioController.text,
    })
        .then((value) => {
      // Success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved successfully')),
      ),
      // Clear text fields
      _nameController.clear(),
      _emailController.clear(),
      _addressController.clear(),
      _bioController.clear(),
    })
        .catchError((error) => {
      // Error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile')),
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            SizedBox(height: 10),
            _buildTextField(_nameController, 'Name', Icons.person),
            SizedBox(height: 10),
            _buildTextField(_emailController, 'Email', Icons.email),
            SizedBox(height: 10),
            _buildTextField(_addressController, 'Address', Icons.home),
            SizedBox(height: 10),
            _buildTextField(_bioController, 'Bio', Icons.info),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfileData,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(72, 132, 151, 1)),
              ),
              child: Text(
                'Save Profile',
                style: TextStyle(color: Colors.white), // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your $label',
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
      ),
      style: TextStyle(fontSize: 16),
    );
  }
}
