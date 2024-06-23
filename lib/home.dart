import 'package:flutter/material.dart';
import 'package:sherophopia/Tabs/homeTab.dart';
import 'package:sherophopia/Tabs/searchTab.dart';
import 'package:sherophopia/Widgets/Drawer.dart';
import 'package:sherophopia/Tabs/communityTab.dart';
import 'package:sherophopia/Tabs/chatbotTab.dart';
import 'package:sherophopia/Tabs/profileTab.dart';
import 'package:sherophopia/Tabs/SettingsTab.dart';

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
    SettingsTab(),
  ];

  var _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          backgroundColor:Color.fromRGBO(72, 132, 151, 1),
          title: Text("Sherophopia",
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700,color:Colors.white))),
      body:Tabs[index],
      drawer:Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color:Color.fromRGBO(72, 132, 151, 1),
              ),
              child: Text('Sherophopia'),
            ),
            ListTile(
              title: const Text('Search'),
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pushReplacementNamed(context, SearchTab.routeName);

              },
            ),
            ListTile(
              title: const Text('About us'),
              selected: _selectedIndex == 1,
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('Contact us'),
              selected: _selectedIndex == 2,
              onTap: () {

              },
            ),
          ],
        ),

      ) ,


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
            BottomNavigationBarItem(icon: Icon(Icons.settings,size: 40,color:Colors.white),label:"")
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

