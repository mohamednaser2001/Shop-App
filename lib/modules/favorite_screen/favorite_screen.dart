

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';

import '../../components/components.dart';
import '../../layout/cubit/app_cubit.dart';
import '../../layout/cubit/shop_states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState ,         //may this code make error
          builder: (context)=> ListView.separated(
            itemCount: ShopCubit.get(context).favModel!.data!.data!.length,
            itemBuilder: (context,index)=>buildListOfItemsItem(ShopCubit.get(context).favModel!.data!.data![index],context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(height: 1.0, color: Colors.grey,),
            ),
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
