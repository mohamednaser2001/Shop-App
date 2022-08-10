

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';

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
            itemBuilder: (context,index)=>buildFavoritesItem(ShopCubit.get(context).favModel!.data!.data![index],context),
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

  Widget buildFavoritesItem(FavoritesData product,context)=>Container(
    height: 100,
    padding:const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(product.product!.image),
              width: 100,
              height: 100,
            ),
            if(product.product!.discount>0) Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              color: Colors.red,
              child:const Text(
                'DISCOUNT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.product!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      product.product!.price.toString(),//  '${product.name}',
                      style:const TextStyle(
                        fontSize: 12.0,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8,),
                    if(product.product!.discount>0)  Text(
                      product.product!.oldPrice.toString(),
                      style:const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding:const EdgeInsets.all(0.0),
                      onPressed: (){
                         ShopCubit.get(context).changeFavorites(product.product!.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: ShopCubit.get(context).favorites[product.product!.id]==true ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

}
