import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:email_validator/email_validator.dart';

class ContactUsViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setMessage(String value) {
    message = value;
    notifyListeners();
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void submit() {
    if (validateAndSave()) {
      // Add your form submission logic here (e.g., send data to a server)
      print('Form submitted: Name: $name, Email: $email, Message: $message');
    }
  }
}
