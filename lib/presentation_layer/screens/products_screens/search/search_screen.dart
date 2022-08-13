import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/favorites/favorites_screen.dart';
import 'package:shop_app/presentation_layer/screens/products_screens/search/search_cubit.dart';
import 'package:shop_app/presentation_layer/widgets/SharedWidgets.dart';

import '../../../../models/search_model.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fromKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<SearchCubit>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('#F18D35'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: fromKey,
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      label: 'Search',
                      prefix: Icons.search,
                      type: TextInputType.text,
                      onSubmit:(String text){
                        BlocProvider.of<SearchCubit>(context).search(text: text);
                      } ,
                    ),
                    const SizedBox(height: 15,),
                    if(state is SearchLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 15,),
                    if(state is SearchSuccess)
                      Expanded(
                      child: ListView.separated(
                        //cubit.model.data.data[index]
                        itemBuilder: (context, index) => buildFavItem(cubit.model.data.data[index],context),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: cubit.model.data.data.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildFavItem(Product model,context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
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
                    padding: EdgeInsets.symmetric(horizontal: 5),
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
