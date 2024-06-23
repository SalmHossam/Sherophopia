import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Tab Example',
      home: HomeTab(),
    );
  }
}

class HomeTab extends StatelessWidget {
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
                backgroundImage: AssetImage('assets/images/profile.jpg'), // Provide image path
              ),
              SizedBox(width: 10), // Add spacing between avatar and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back', style: TextStyle(fontSize: 16)),
                  Text('Salma Soliman', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('How are you feeling today?', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FeelingIcon(icon: Icons.sentiment_very_satisfied, label: 'Satisfy'),
              FeelingIcon(icon: Icons.sentiment_dissatisfied, label: 'Sad'),
              FeelingIcon(icon: Icons.sentiment_very_dissatisfied, label: 'Angry'),
              FeelingIcon(icon: Icons.sentiment_satisfied, label: 'Happy'),
              FeelingIcon(icon: Icons.sentiment_neutral, label: 'Worry'),
              FeelingIcon(icon: Icons.add_circle_outline, label: 'Other'),
            ],
          ),
          SizedBox(height: 20),
          QuoteSection(),
          SizedBox(height: 20),
          UpcomingSessions(),
        ],
      ),
    );
  }
}

class FeelingIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  FeelingIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40),
        Text(label),
      ],
    );
  }
}

class QuoteSection extends StatefulWidget {
  @override
  _QuoteSectionState createState() => _QuoteSectionState();
}

class _QuoteSectionState extends State<QuoteSection> {
  String _quote = 'Everything will be okay';

  Future<void> _getRandomQuote() async {
    final response = await http.get(Uri.parse('https://api.quotable.io/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _quote = data['content'];
      });
    } else {
      setState(() {
        _quote = 'Failed to load a quote';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(72, 132, 151, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Quotes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          Text(_quote, style: TextStyle(fontSize: 14, color: Colors.white)),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(onPressed: () async {
                final result = await Share.shareWithResult(_quote);

                if (result.status == ShareResultStatus.success) {
                  Fluttertoast.showToast(msg: 'Your Quote Shared successfully');
                }
                else{
                  Fluttertoast.showToast(msg:'Failed to share your Quote');

                }
              }, style: ElevatedButton.styleFrom(
                primary: Colors.white, // Button color
                onPrimary: Color.fromRGBO(72, 132, 151, 1), // Text color
              ),
                child: Icon(Icons.share),),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: _getRandomQuote,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Button color
                    onPrimary: Color.fromRGBO(72, 132, 151, 1), // Text color
                  ),
                  child: Icon(Icons.refresh_rounded),
                ),
              ),
              Spacer(),
              ElevatedButton(onPressed: () async{
                await Clipboard.setData(ClipboardData(text: _quote));
                Fluttertoast.showToast(msg: "Copied Successfully");

              }, style: ElevatedButton.styleFrom(
                primary: Colors.white, // Button color
                onPrimary: Color.fromRGBO(72, 132, 151, 1), // Text color
              ),
                child: Icon(Icons.copy),),
            ],
          ),
        ],
      ),
    );
  }
}

class UpcomingSessions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Sessions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/images/doctor1.jpg')),
          title: Text('Dr. Ali Maher'),
          subtitle: Text('Topic: Anxiety disorders\nToday at 8 PM'),
          trailing: Checkbox(value: true, onChanged: (bool? value) {}),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/images/doctor2.jpg')),
          title: Text('Dr. Mai Adel'),
          subtitle: Text('Topic: Depression'),
          trailing: Checkbox(value: false, onChanged: (bool? value) {}),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/images/doctor2.jpg')),
          title: Text('Dr. Mai Adel'),
          subtitle: Text('Topic: Depression'),
          trailing: Checkbox(value: false, onChanged: (bool? value) {}),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/images/doctor2.jpg')),
          title: Text('Dr. Mai Adel'),
          subtitle: Text('Topic: Depression'),
          trailing: Checkbox(value: false, onChanged: (bool? value) {}),
        ),
      ],
    );
  }
}


