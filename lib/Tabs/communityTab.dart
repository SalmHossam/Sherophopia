import 'package:flutter/material.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab({super.key});

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


            }, style: ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll(Color.fromRGBO(72, 132, 151, 100))),child: Text("Start",style: TextStyle(fontSize: 30),)),
            SizedBox(
              height: 50,
            ),
            Image(image: AssetImage("assets/images/Community.png"),width: double.infinity,)

          ],
        )
    );
  }
}
