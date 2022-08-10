

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/models/categories_models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder:(context,state)=> ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        itemBuilder: (context,index)=>buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
        separatorBuilder: (context,index)=> Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildCategoriesItem(DataModel model)=>Row(
    children: [
      Image(
        image: NetworkImage(model.image),
        width: 90.0,
        height: 90.0,
        fit: BoxFit.cover,
      ),
      const SizedBox(width: 20.0,),
      Text(
        model.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const Spacer(),
      const Icon(
        Icons.arrow_forward_ios_rounded,
      ),
    ],
  );

}
