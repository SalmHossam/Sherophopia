import 'package:sherophopia/DoctorTabs/YourName.dart';
import 'package:flutter/material.dart';

class UploadResume extends StatefulWidget {
  static const String routeName="Home";

  @override
  State<UploadResume> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UploadResume> {
  TextEditingController yourController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    String enteredName='';
    return Scaffold(
      appBar: AppBar(title: Text('Upload & Download',style: TextStyle(color: Colors.white),),backgroundColor:Color.fromRGBO(72, 132, 151, 1)),
      body: Column(
        children: [
          SizedBox(height: 150,),
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: TextFormField (
               controller:TextEditingController(),decoration: InputDecoration(hintText: 'Please Enter Your Name',
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
               onChanged:(value){
                 enteredName=value;
               },
             ),
           ),

          SizedBox(height: 50,),
          ElevatedButton(onPressed: () {
            if (enteredName.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => YourName(userName: enteredName)),
              );
            } else {
              // Notify the user to enter a name
            }
          },
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(72, 132, 151, 1)),
              child: Text('Done',style: TextStyle(color: Colors.white),))
        ],
      ),

    );
  }
}
