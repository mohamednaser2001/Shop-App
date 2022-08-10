


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  required String text,
required ToastStates state,
})=> Fluttertoast.showToast(
    msg:text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseToastState(state),
    textColor: Colors.white,
    fontSize: 16.0
);


