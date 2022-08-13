import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/data_layer/network/local/cache_helper.dart';
import 'package:shop_app/presentation_layer/screens/login/shop_login_cubit.dart';
import 'package:shop_app/presentation_layer/screens/register/register_screen.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/home_screen.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            ///ToDo: go to home screen
            if (state.loginModel.status == true) {
              showToast(state: ToastStates.SUCCESS, msg: state.loginModel.message);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value){
                token = state.loginModel.data.token;
                navigateToAndReplacement(context, ShopLayout());
              });
            } else {
              showToast(state: ToastStates.ERROR, msg: state.loginModel.message);
            }
          }
        },
        builder: (context, state) => Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      'login now to get great offers',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultFormField(
                      controller: emailController,
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      onSubmit: (value) {
                        BlocProvider.of<ShopLoginCubit>(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text);
                      },
                      isPassword:
                          BlocProvider.of<ShopLoginCubit>(context).isPassword,
                      controller: passwordController,
                      label: 'Password',
                      prefix: Icons.lock_outline,
                      type: TextInputType.visiblePassword,
                      suffix: BlocProvider.of<ShopLoginCubit>(context).suffix,
                      suffixPressed: () {
                        BlocProvider.of<ShopLoginCubit>(context)
                            .changePasswordIcon();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingState,
                      builder: (BuildContext context) {
                        return defaultButton(
                          text: 'login',
                          function: () {
                            BlocProvider.of<ShopLoginCubit>(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          },
                          isUpper: true,
                          color: HexColor('#F18D35'),
                        );
                      },
                      fallback: (BuildContext context) => Center(
                          child: CircularProgressIndicator(
                        color: HexColor('#F18D35'),
                      )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account ?'),
                        defaultTextButton(
                            function: () {
                              navigateTo(context,  RegisterScreen());
                            },
                            text: 'Register'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
