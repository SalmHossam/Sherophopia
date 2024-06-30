import 'package:flutter/material.dart';

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

