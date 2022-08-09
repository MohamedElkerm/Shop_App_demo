import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/data_layer/network/local/cache_helper.dart';
import 'package:shop_app/presentation_layer/screens/login/login.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/search/search_screen.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/shop_app_cubit.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<ShopCubit>(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 5.0,
              backgroundColor: HexColor('#F18D35'),
              title: const Text('Salla'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              // Items in bottom nav bar as icons and texts not widgets
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: HexColor('#F18D35'),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.grid_view,
                    color: HexColor('#F18D35'),
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: HexColor('#F18D35'),
                  ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: HexColor('#F18D35'),
                  ),
                  label: 'Settings',
                ),
              ],
            ),
            //body: ,
          );
        });
  }
}
