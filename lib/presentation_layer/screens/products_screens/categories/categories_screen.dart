import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/shop_app_cubit.dart';

import '../../../../models/categories.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = BlocProvider.of<ShopCubit>(context);
        return ListView.separated(
          itemBuilder: (context,index)=>buildCatItem(model: cubit.categoriesModel.data.data[index]),
          separatorBuilder: (context,index)=>Divider(),
          itemCount: cubit.categoriesModel.data.data.length,
        );
      }
    );
  }

  Widget buildCatItem({@required ProductData model}) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              // Don't forget
              image: NetworkImage(model.image),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
            ),
          ],
        ),
      );
}
