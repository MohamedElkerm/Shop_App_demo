import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/data_layer/network/local/cache_helper.dart';
import 'package:shop_app/data_layer/network/remote/dio_helper.dart';
import 'package:shop_app/presentation_layer/screens/login/login.dart';
import 'package:shop_app/presentation_layer/screens/login/shop_login_cubit.dart';
import 'package:shop_app/presentation_layer/screens/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/home_screen.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/shop_app_cubit.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

import 'bloc_obsever/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      ShopLoginCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  //bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding;
  Widget widget;
  if(CacheHelper.getData(key: 'onBoarding')!=null){
    onBoarding = CacheHelper.getData(key: 'onBoarding');
  }
  else{
    onBoarding = false;
  }
  if(CacheHelper.getData(key: 'token')!=null){
    token = CacheHelper.getData(key: 'token');
  }else{
    token = null;
  }
  if(onBoarding!=null){
    if(token!=null){
      widget = ShopLayout();
    }else{
      widget = ShopLoginScreen();
    }
  }else{
    widget =OnBoardingScreen() ;
  }
  print(onBoarding);

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
   Widget  startWidget;
  MyApp({Key key, @required this.startWidget}) : super(key: key);
   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories() ,
       child: BlocConsumer<ShopCubit,ShopStates>(
         listener: (BuildContext context, state) {  },
         builder: (BuildContext context, state)=>MaterialApp(
           debugShowCheckedModeBanner: false,
           title: 'Shop App',
           theme: ThemeData(
             bottomNavigationBarTheme: BottomNavigationBarThemeData(
               backgroundColor: HexColor('#F18D35'),
               selectedItemColor: HexColor('#F18D35'),
               unselectedItemColor: Colors.red
             ),
               //scaffoldBackgroundColor: HexColor('#FFFFFF'),
               floatingActionButtonTheme: FloatingActionButtonThemeData(
                   foregroundColor: HexColor('#FFFFFF'),
                   backgroundColor: HexColor('#F18D35')),
               fontFamily: 'Lato'),
           home:startWidget,
         ),
       )
     );
   }
}

