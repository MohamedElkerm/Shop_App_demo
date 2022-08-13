import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/data_layer/network/local/cache_helper.dart';
import 'package:shop_app/presentation_layer/screens/login/shop_login_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation_layer/screens/register/register_cubit.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/home_screen.dart';
import '../../widgets/SharedWidgets.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            ///ToDo: go to home screen
            if (state.registerModel.status == true) {
              showToast(state: ToastStates.SUCCESS, msg: state.registerModel.message);
              CacheHelper.saveData(key: 'token', value: state.registerModel.data.token).then((value){
                token = state.registerModel.data.token;
                navigateToAndReplacement(context, ShopLayout());
              });
            } else {
              showToast(state: ToastStates.ERROR, msg: state.registerModel.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('#F18D35'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Text(
                        'Register now to get great offers',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultFormField(
                        controller: nameController,
                        label: 'User Name',
                        prefix: Icons.person,
                        type: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 15,
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
                        isPassword:
                            BlocProvider.of<RegisterCubit>(context).isPassword,
                        controller: passwordController,
                        label: 'Password',
                        prefix: Icons.lock_outline,
                        type: TextInputType.visiblePassword,
                        suffix: BlocProvider.of<RegisterCubit>(context).suffix,
                        suffixPressed: () {
                          BlocProvider.of<RegisterCubit>(context)
                              .changePasswordIcon();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        label: 'Phone',
                        prefix: Icons.phone,
                        type: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                            text: 'Register',
                            function: () {
                              BlocProvider.of<RegisterCubit>(context)
                                  .userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
