

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_cubit.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_states.dart';

import '../../components/components.dart';
import '../../layout/cubit/app_cubit.dart';
import '../../models/search_model/search_model.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>ShopAppSearchCubit(),
      child: BlocConsumer<ShopAppSearchCubit,ShopAppSearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(
                    context,);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
              title:const Text(
                'Search',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                    onFieldSubmitted: (text){
                      ShopAppSearchCubit.get(context).getSearch(text);
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter product name';
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0,),
                  Expanded(
                    child: ListView.separated(
                      itemCount:ShopAppSearchCubit.get(context).searchModel!=null ? ShopAppSearchCubit.get(context).searchModel!.data!.data!.length : 0,
                      itemBuilder: (context,index)=>buildSearchItem(ShopAppSearchCubit.get(context).searchModel!.data!.data![index],context),
                      separatorBuilder: (context,index)=>Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(height: 1.0, color: Colors.grey,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget buildSearchItem(ProductSearchModel product,context)=>Container(
    height: 100,
    padding:const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(product.image),
              width: 100,
              height: 100,
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
                  product.name,
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
                      product.price.toString(),//  '${product.name}',
                      style:const TextStyle(
                        fontSize: 12.0,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding:const EdgeInsets.all(0.0),
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(product.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: ShopCubit.get(context).favorites[product.id]==true ? Colors.red : Colors.grey,
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
