import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class MySlider extends StatelessWidget {
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
          key: _key,
          appBar:
          SliderAppBar(
              appBarColor: Color.fromRGBO(72, 132, 150, 100),
              appBarHeight: 100,
              drawerIconColor: Colors.white,
              title: Text("Sherophopia",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700,color:Colors.white))),
          slider: Container(color: Color.fromRGBO(72, 132, 150, 100),),sliderBoxShadow:
        SliderBoxShadow(color: Colors.transparent,),

          child: Container(color: Colors.white),
        ));
  }
}
