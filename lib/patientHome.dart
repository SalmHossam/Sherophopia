import 'package:flutter/material.dart';
import 'package:sherophopia/Tabs/homeTab.dart';
import 'package:sherophopia/Tabs/searchTab.dart';
import 'package:sherophopia/Widgets/Drawer.dart';
import 'package:sherophopia/Tabs/communityTab.dart';
import 'package:sherophopia/Tabs/chatbotTab.dart';
import 'package:sherophopia/Tabs/profileTab.dart';
import 'package:sherophopia/Tabs/SettingsTab.dart';
import 'package:sherophopia/introductionScreen.dart';

class Home extends StatefulWidget {
  static const String routeName="HomeScreen";

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int index=0;
  List<Widget>Tabs=[
    HomeTab(),
    CommunityTab(),
    ProfileTab(),
    SearchTab(),
  ];

  var _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
          backgroundColor:Color.fromRGBO(72, 132, 151, 1),
          title: Text("Sherophopia",
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700,color:Colors.white))),
      body:Tabs[index],
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(72, 132, 151, 1),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Sherophopia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('Logout', style: TextStyle(fontSize: 18)),
              selectedColor: Colors.black,
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pushReplacementNamed(context, IntroductionScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.black),
              title: Text('About us', style: TextStyle(fontSize: 18)),
              selectedColor: Colors.black,
              selected: _selectedIndex == 1,
              onTap: () {
                // Add your About Us navigation or functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.black),
              title: Text('Contact us', style: TextStyle(fontSize: 18)),
              selectedColor: Colors.black,
              selected: _selectedIndex == 2,
              onTap: () {
                // Add your Contact Us navigation or functionality here
              },
            ),
          ],
        ),
      ),


      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(72, 132, 151, 1),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          currentIndex: index,



          items:  [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded,size: 40,color:Colors.white),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.groups_rounded,size: 40,color:Colors.white),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person,size: 40,color:Colors.white),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search,size: 40,color:Colors.white),label:"")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat,color: Colors.white,size: 40,),
        backgroundColor:Color.fromRGBO(72, 132, 151, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotTab()),
          );          setState(() {
          });
        },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }


}

