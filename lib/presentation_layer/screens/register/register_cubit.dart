import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data_layer/network/end_points.dart';
import 'package:shop_app/data_layer/network/remote/dio_helper.dart';
import 'package:shop_app/models/login_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void userRegister(
      {@required email, @required password, @required phone, @required name}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      //print(value.data);
      ShopLoginModel registerModel = ShopLoginModel.fromJson(value.data);
       print('Success in register');
      // print('message is : ${loginModel!.message}');
      // print('token is : ${loginModel!.data!.token}');
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((err) {
      print('register error is : $err.toString()');
      emit(ShopRegisterErrorState(err.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordSuffix());
  }
}
