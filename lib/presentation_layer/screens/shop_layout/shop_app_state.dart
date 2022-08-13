part of 'shop_app_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{
  final  err;
  ShopErrorHomeDataState({this.err});
}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{
  final  err;
  ShopErrorCategoriesDataState({this.err});
}

class ShopSuccessChangeFavoriteState extends ShopStates{}

class ShopChangeFavoriteState extends ShopStates{}

class ShopErrorChangeFavoriteState extends ShopStates{
  final  err;
  ShopErrorChangeFavoriteState({this.err});
}

class ShopSuccessFavoritesDataState extends ShopStates{}

class ShopLoadingFavoritesDataState extends ShopStates{}

class ShopErrorFavoritesDataState extends ShopStates{
  final  err;
  ShopErrorFavoritesDataState({this.err});
}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataState({@required this.loginModel});
}

class ShopLoadingUserDataState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates{
  final  err;
  ShopErrorUserDataState({this.err});
}