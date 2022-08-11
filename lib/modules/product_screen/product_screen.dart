import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/models/categories_models/categories_model.dart';
import 'package:shop_app/models/models.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessFavoritesState){
          if(!state.model!.status){
            showToast(text: state.model!.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).model !=null && ShopCubit.get(context).categoriesModel !=null ,         //may this code make error
            builder: (context)=> productBuilder(ShopCubit.get(context).model,ShopCubit.get(context).categoriesModel,context),
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model,CategoriesModel? categoriesModel,context) =>SingleChildScrollView(
    physics:const BouncingScrollPhysics(),
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            // banners is the list of maps in HomeDateModel
              items: model!.data.banners.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image(
                              image: NetworkImage(e.image),
                            width: double.infinity,
                            fit:  BoxFit.cover,
                          ),
                        ),
                      ),
              ).toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayAnimationDuration: Duration(seconds: 1,),
                autoPlayInterval: Duration(seconds: 3,),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ) ,
          ),
          const SizedBox(height: 10,),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Text(
                  'Categories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6,),
                Container(height: 100.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index) => buildCategoriesItem(categoriesModel!.data.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                      itemCount:  categoriesModel!.data.data.length,
                  ),
                ),
                const SizedBox(height: 20,),
               const Text(
                  'New Products',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            color: Colors.grey.shade100,     ///////////
            padding: EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1/1.41,
              children: List.generate(
                      model.data.products.length,
                      (index) => buildGridProduct(model.data.products[index],context),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildCategoriesItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        width: 100.0,
        height: 100.0,
      ),
      Container(
        padding:const EdgeInsets.all(4),
        width: 100.0,
        color: Colors.black.withOpacity(0.7),
        child: Text(
          model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );


  Widget buildGridProduct(Products product,context)=> Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(product.image),
              width: double.infinity,
              height: 150,
            ),
            if(product.discount>0) Container(
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

        Padding(
          padding: const EdgeInsets.only(top: 12,right: 12,left: 12,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${product.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${product.price}',//  '${product.name}',
                    style:const TextStyle(
                      fontSize: 12.0,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 const SizedBox(width: 8,),
                 if(product.discount>0)  Text(
                   '${product.oldPrice}',
                   style:const TextStyle(
                     fontSize: 10.0,
                     color: Colors.grey,
                     fontWeight: FontWeight.bold,
                     decoration: TextDecoration.lineThrough,
                   ),
                 ),
                 const Spacer(),
                  IconButton(
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
      ],
    ),
  );

}
