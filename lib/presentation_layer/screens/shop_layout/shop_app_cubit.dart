import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data_layer/network/end_points.dart';
import 'package:shop_app/data_layer/network/remote/dio_helper.dart';
import 'package:shop_app/models/categories.dart';
import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/categories/categories_screen.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/favorites/favorites_screen.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/products/products_screen.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/settings/settings_screen.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

part 'shop_app_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token, lang: 'en').then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data);
      //printFullText(homeModel.data.banners.length);
      print('Success homeModel has recived');
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites);

      emit(ShopSuccessHomeDataState());
    }).catchError((err) {
      emit(ShopErrorHomeDataState(err: err));
      print('error is : ${err.toString()}');
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.data);
      //printFullText(homeModel.data.banners.length);
      print('Success categoriesModel has recived');
      emit(ShopSuccessCategoriesDataState());
    }).catchError((err) {
      emit(ShopErrorCategoriesDataState(err: err));
      print('error is : ${err.toString()}');
    });
  }

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId) {
    /// Can't understand
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel.status){
        favorites[productId] = !favorites[productId];
      }else{
        getFavorites();
      }
      print('fav change done');
      print(changeFavoritesModel.message);
      showToast(state: ToastStates.SUCCESS, msg: changeFavoritesModel.message);
      emit(ShopSuccessChangeFavoriteState());
    }).catchError((err) {
      showToast(state: ToastStates.ERROR, msg: changeFavoritesModel.message);
      print(err.toString());
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoriteState(err: err));
    });
  }

  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(url: FAVORITES, lang: 'en',token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel.data);
      //printFullText(homeModel.data.banners.length);
      print('Success Favorites Model has recived');
      emit(ShopSuccessFavoritesDataState());
    }).catchError((err) {
      emit(ShopErrorFavoritesDataState(err: err));
      print('error is : ${err.toString()}');
    });
  }


}
