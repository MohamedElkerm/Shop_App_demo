import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/presentation_layer/screens/on_boarding/on_boarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: ThemeData(
        scaffoldBackgroundColor:HexColor('#FFFFFF') ,
        floatingActionButtonTheme:FloatingActionButtonThemeData(foregroundColor: HexColor('#FFFFFF'),backgroundColor:HexColor('#F18D35')) ,
        fontFamily: 'Lato'
      ),
      home: OnBoardingScreen(),
    );
  }
}