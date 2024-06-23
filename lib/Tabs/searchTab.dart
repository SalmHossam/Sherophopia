import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});
  static const String routeName="SearchScreen";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor:Color.fromRGBO(72, 132, 151, 100) ,
          title: Text("Sherophopia",
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700,color:Colors.white))),
    );
  }
}

