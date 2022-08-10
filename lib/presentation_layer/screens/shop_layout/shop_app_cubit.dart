import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data_layer/network/end_points.dart';
import 'package:shop_app/data_layer/network/remote/dio_helper.dart';
import 'package:shop_app/models/categories.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/categories/categories_screen.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/favorites/favorites_screen.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/products/products_screen.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/settings/settings_screen.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

part 'shop_app_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());
  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME,token:token,lang: 'en').then((value){
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data);
      //printFullText(homeModel.data.banners.length);
      print('Success homeModel has recived');
      emit(ShopSuccessHomeDataState());
    }).catchError((err){
      emit(ShopErrorHomeDataState(err: err));
      print('error is : ${err.toString()}');
    });
  }

  CategoriesModel categoriesModel;
  void getCategories(){
    DioHelper.getData(url: GET_CATEGORIES,lang: 'en').then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.data);
      //printFullText(homeModel.data.banners.length);
      print('Success categoriesModel has recived');
      emit(ShopSuccessCategoriesDataState());
    }).catchError((err){
      emit(ShopErrorCategoriesDataState(err: err));
      print('error is : ${err.toString()}');
    });
  }

}
