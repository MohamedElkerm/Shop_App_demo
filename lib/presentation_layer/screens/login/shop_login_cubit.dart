import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data_layer/network/end_points.dart';
import 'package:shop_app/data_layer/network/remote/dio_helper.dart';
import 'package:shop_app/models/login_model.dart';

part 'shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({@required email, @required password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      //print(value.data);
      ShopLoginModel loginModel = ShopLoginModel.fromJson(value.data);
      // print('status is : ${loginModel!.status}');
      // print('message is : ${loginModel!.message}');
      // print('token is : ${loginModel!.data!.token}');
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((err) {
      emit(ShopLoginErrorState(err.toString()));
    });
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordIcon(){
    isPassword = !isPassword;
    suffix =isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordSuffix());
  }
}
