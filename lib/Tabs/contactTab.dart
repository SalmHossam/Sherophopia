import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for Clipboard functionality
import 'package:provider/provider.dart';
import '../Models/contactViewModel.dart';

class ContactUsPage extends StatelessWidget {
  static String routeName = "Contact";
  static const String emailAddress = 'sherophobia2024@gmail.com'; // Email address constant

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactUsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
          backgroundColor: Color.fromRGBO(72, 132, 151, 1),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ContactUsViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    _buildHeaderImage(),
                    SizedBox(height: 20),
                    _buildTextField(
                      label: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) => viewModel.setName(value!),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      label: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => viewModel.setEmail(value!),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      label: 'Message',
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                      onSaved: (value) => viewModel.setMessage(value!),
                    ),
                    SizedBox(height: 20),
                    _buildSubmitButton(viewModel, context),
                    SizedBox(height: 20),
                    _buildCopyEmailButton(context), // Pass context here
                    SizedBox(height: 50),
                    Image.asset(
                      "assets/images/contact_us.gif",
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Image.asset(
      'assets/images/contact_us_header.png',
      height: 200,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
    );
  }

  Widget _buildSubmitButton(ContactUsViewModel viewModel, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color.fromRGBO(72, 132, 151, 1),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        elevation: MaterialStatePropertyAll(4),
      ),
      onPressed: viewModel.isSubmitting ? null : () => viewModel.submit(context),
      child: viewModel.isSubmitting
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : Text(
        'Submit',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildCopyEmailButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Or use the email to contact us:',
          style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emailAddress,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.copy, color: Colors.grey[700]),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: emailAddress));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Email address copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
