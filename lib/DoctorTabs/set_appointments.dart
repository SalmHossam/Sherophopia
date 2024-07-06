import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
//const id for each user
class SetAppointments extends StatefulWidget {
  static String routeName="set";

  @override
  _SetAppointmentsState createState() => _SetAppointmentsState();
}

class _SetAppointmentsState extends State<SetAppointments> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('user_id') ?? '';
      if (_userId.isEmpty) {
        _generateUserId();
      }
    });
  }

  Future<void> _generateUserId() async {
    final uuid = Uuid();
    final newUserId = uuid.v4();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', newUserId);
    setState(() {
      _userId = newUserId;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2024),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color.fromRGBO(72, 132, 151, 1), // Header background color
            hintColor: Color.fromRGBO(72, 132, 151, 1), // Selected day color
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(72, 132, 151, 1), // Header background color
              onPrimary: Colors.white, // Header text and icon color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color.fromRGBO(72, 132, 151, 1), // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 47),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // change the border color
              primary: Color.fromRGBO(72, 132, 151, 1),
              // change the text color
              onSurface: Color.fromRGBO(72, 132, 151, 1),
            ),
            // button colors
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Color.fromRGBO(72, 132, 151, 1),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null)
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
  }

  Future<void> _submitAppointment() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _startTime != null &&
        _endTime != null) {
      final startDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _startTime!.hour,
        _startTime!.minute,
      );
      final endDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _endTime!.hour,
        _endTime!.minute,
      );

      // Save the available slot to Firestore
      await FirebaseFirestore.instance.collection('available_slots').add({
        'start_time': startDateTime,
        'end_time': endDateTime,
        'user_id': _userId, // Add the user ID to the document
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Available slot added successfully')),
      );

      // Reset the form
      setState(() {
        _selectedDate = null;
        _startTime = null;
        _endTime = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Available Appointments'),
        backgroundColor: Color.fromRGBO(72, 132, 151, 1),
        actions: [
          IconButton(
            onPressed: _submitAppointment,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(_selectedDate == null
                    ? 'No date chosen!'
                    : DateFormat.yMd().format(_selectedDate!)),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text(_startTime == null
                    ? 'No start time chosen!'
                    : _startTime!.format(context)),
                trailing: Icon(Icons.access_time),
                onTap: () => _selectTime(context, true),
              ),
              ListTile(
                title: Text(_endTime == null
                    ? 'No end time chosen!'
                    : _endTime!.format(context)),
                trailing: Icon(Icons.access_time),
                onTap: () => _selectTime(context, false),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitAppointment,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(72, 132, 151, 1),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                ),

                child: Text('Set Available Slot'),
              ),
              SizedBox(height: 40,),
              Image(image: AssetImage('assets/images/Work time-cuate.png'))
            ],
          ),
        ),
      ),
    );
  }
}