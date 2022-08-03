import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/data_layer/network/remote/dio_helper.dart';
import 'package:shop_app/presentation_layer/screens/login/shop_login_cubit.dart';
import 'package:shop_app/presentation_layer/screens/on_boarding/on_boarding_screen.dart';

import 'bloc_obsever/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      ShopLoginCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
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
          scaffoldBackgroundColor: HexColor('#FFFFFF'),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: HexColor('#FFFFFF'),
              backgroundColor: HexColor('#F18D35')),
          fontFamily: 'Lato'),
      home: OnBoardingScreen(),
    );
  }
}
