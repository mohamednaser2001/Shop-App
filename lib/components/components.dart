


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../layout/cubit/app_cubit.dart';
import '../models/models.dart';

Widget onBoardingScreen(OnBoardingItem item){
 return Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children:
   [
     Expanded(
       child: Image(
         image: AssetImage('${item.image}'),
       ),
     ),
     SizedBox(height: 30.0,),
     Text(
       '${item.title}',
       style: TextStyle(
         fontWeight: FontWeight.w700,
         fontSize: 24.0,
       ),
     ),
     SizedBox(height: 15.0,),
     Text(
       '${item.body}',
       style: TextStyle(
         fontWeight: FontWeight.w700,
         fontSize: 14.0,
         color: Colors.grey.shade800,
       ),
     ),
   ],
 );
}


enum ToastStates{ERROR,SUCCESS,WARNING}

Color choseToastState(ToastStates state){

  Color color;
  switch(state){
    case ToastStates.SUCCESS: color=Colors.green;
    break;
    case ToastStates.ERROR: color=Colors.red;
    break;
    case ToastStates.WARNING: color=Colors.amber;
    break;
  }
  return color;
}

void showToast({
  required String? text,
required ToastStates state,
})=> Fluttertoast.showToast(
    msg:text==null ?'Error':text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseToastState(state),
    textColor: Colors.white,
    fontSize: 16.0
);


Widget buildListOfItemsItem( product,context)=>Container(
  height: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.0),
    color: Colors.white,
  ),
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
