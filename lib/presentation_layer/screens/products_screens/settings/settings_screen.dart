import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/shop_app_cubit.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();


  @override
  didChangeDependencies(){
    super.didChangeDependencies();
    BlocProvider.of<ShopCubit>(context).getUserData();

  }

  @override
  initState(){
    super.initState();
    // print("Say Hello");
    BlocProvider.of<ShopCubit>(context).getUserData();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ShopCubit>(context);
        var model = cubit.userModel;

        return ConditionalBuilder(
          condition: cubit.getUserDataSuccess == false,
          fallback: (BuildContext context) {
            nameController.text = model.data.name;
            emailController.text = model.data.email;
            phoneController.text = model.data.phone;
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameController,
                    label: 'Name',
                    prefix: Icons.person,
                    type: TextInputType.name,
                    enable: false,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    label: 'E-Mail',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    enable: false,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    enable: false,
                    controller: phoneController,
                    label: 'Phone',
                    prefix: Icons.phone,
                    type: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      color: color,
                      text: 'Logout',
                      function: () {
                        signOut(context: context);
                      })
                ],
              ),
            );
          },
          builder: (context) {
            return Center(
                child: CircularProgressIndicator(
              color: color,
            ));
          },
        );
      },
    );
  }
}
