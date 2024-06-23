import 'package:flutter/material.dart';

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
                radius:45,
                backgroundImage: AssetImage('assets/images/profile.jpg'), // Provide image path
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back'),
                  Text('Salma Soliman'),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('How are you feeling today?'),
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

class QuoteSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Color.fromRGBO(72, 132, 151, 100) ,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Quotes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Everything will be okay', style: TextStyle(fontSize: 14)),
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
          leading: CircleAvatar(backgroundImage: AssetImage('assets/images/Doctor2.jpg')),
          title: Text('Dr. Mai Adel'),
          subtitle: Text('Topic: Depression'),
          trailing: Checkbox(value: false, onChanged: (bool? value) {}),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/images/Doctor2.jpg')),
          title: Text('Dr. Mai Adel'),
          subtitle: Text('Topic: Depression'),
          trailing: Checkbox(value: false, onChanged: (bool? value) {}),
        ),
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage('assets/images/Doctor2.jpg')),
          title: Text('Dr. Mai Adel'),
          subtitle: Text('Topic: Depression'),
          trailing: Checkbox(value: false, onChanged: (bool? value) {}),
        ),
      ],
    );
  }
}
