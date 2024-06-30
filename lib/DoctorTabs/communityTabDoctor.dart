import 'package:flutter/material.dart';
import 'package:sherophopia/DoctorTabs/createComunity.dart';
import 'package:sherophopia/Tabs/joinComunity.dart';

class CommunityTabDoctor extends StatelessWidget {
  const CommunityTabDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Text("Welcome to our Community "),
            Text("Let’s Start our discussion ",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, CreateCommunityScreen.routeName);


            }, style: ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll(Color.fromRGBO(72, 132, 151, 1))),
                child: Text("Create",style: TextStyle(fontSize: 30),)),
            SizedBox(
              height: 50,
            ),
            Image(image: AssetImage("assets/images/Community.png"),width: double.infinity,)

          ],
        )
    );
  }
}
