import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/categories.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/presentation_layer/screens/shop_layout/shop_app_cubit.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ShopCubit>(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => productsBuilder(
              model: cubit.homeModel, categoriesModel: cubit.categoriesModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: color,
            ),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
          {@required HomeModel model,
          @required CategoriesModel categoriesModel}) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: model.data.banners
                        .map((e) => Image(
                              image: NetworkImage(e.image),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      height: 250.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, color: color),
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, color: color),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    color: Colors.grey[300],
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 1.7,
                      children: List.generate(
                        model.data.products.length,
                        (index) =>
                            buildGridProduct(model: model.data.products[index]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(ProductData model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              '${model.image}',
            ),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
              width: 100.0,
              color: Colors.black.withOpacity(0.6),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: whiteColor),
              )),
        ],
      );

  Widget buildGridProduct({@required model}) =>
      BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Container(
            color: whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                      width: double.infinity,
                      height: 200.0,
                    ),
                    if (model.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: color,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(color: whiteColor, fontSize: 8),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, height: 1.3),
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: TextStyle(
                                fontSize: 12, height: 1.3, color: color),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model.discount != 0)
                            Text(
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
                              BlocProvider.of<ShopCubit>(context)
                                  .changeFavorites(model.id);
                            },
                            icon: CircleAvatar(
                              backgroundColor:
                                  BlocProvider.of<ShopCubit>(context)
                                          .favorites[model.id]
                                      ? color
                                      : Colors.grey,
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
          );
        },
      );
}
