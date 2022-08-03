import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/data_layer/network/local/cache_helper.dart';
import 'package:shop_app/presentation_layer/screens/login/login.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: HexColor('#F18D35'),
        title: const Text('Salla'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.removeData(key: 'token').then((value){
                if(value){
                  navigateTo(context, ShopLoginScreen());
                }
              });
            },
            child: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      //body: ,
    );
  }
}
