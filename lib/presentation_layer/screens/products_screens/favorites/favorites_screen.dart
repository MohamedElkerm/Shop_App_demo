import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/favorites_model.dart';

import '../../shop_layout/shop_app_cubit.dart';

class FavoritesScreen extends StatefulWidget {

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {


  @override
  didChangeDependencies(){
    super.didChangeDependencies();
    BlocProvider.of<ShopCubit>(context).getFavorites();

  }

  @override
  initState(){
    super.initState();
    BlocProvider.of<ShopCubit>(context).getFavorites();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<ShopCubit>(context);
          return ConditionalBuilder(
              fallback: (BuildContext context) {
                return  Center(child:  CircularProgressIndicator(color: color,));
              },
              builder: (BuildContext context) {
                return ListView.separated(
                  itemBuilder: (context, index) => buildFavItem(cubit.favoritesModel.data.data[index].product,context),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cubit.favoritesModel.data.data.length,
                );
              },
              condition: cubit.getFavSuccess == true,
          );
        }
    );
  }

  Widget buildFavItem(Product model,context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: color,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: whiteColor, fontSize: 8),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style:
                        TextStyle(fontSize: 12, height: 1.3, color: color),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          ///Error is here ****************************************************************************
                          '${model.oldPrice.round()}',
                          style: const TextStyle(
                            fontSize: 10,
                            height: 1.3,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          print(model.id);
                          BlocProvider.of<ShopCubit>(context).changeFavorites(
                              model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: BlocProvider
                              .of<ShopCubit>(context)
                              .favorites[model.id] ? color : Colors.grey,
                          child: Icon(
                            Icons.favorite_border_outlined,
                            size: 15,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
