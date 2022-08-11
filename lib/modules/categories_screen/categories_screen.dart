

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
      builder:(context,state)=> Container(
        padding:const EdgeInsets.all(16.0),
        color: Colors.grey.shade100,
        child: ListView.separated(
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
          itemBuilder: (context,index)=>buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
        ),
      ),
    );
  }

  Widget buildCategoriesItem(DataModel model)=>Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: Colors.white,
    ),
    child: Row(
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
    ),
  );

}
