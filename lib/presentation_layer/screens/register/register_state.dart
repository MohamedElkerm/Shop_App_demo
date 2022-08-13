part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ShopRegisterLoadingState extends RegisterState {}

class ShopRegisterSuccessState extends RegisterState {
  final ShopLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends RegisterState {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordSuffix extends RegisterState {}

