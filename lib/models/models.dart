

import 'package:flutter/material.dart';

class OnBoardingItem{
  String image;
  String title;
  String body;

  OnBoardingItem({
   required this.image,
   required this.body,
   required this.title,
});
}


class ShopLoginModel{
  late bool status;
  String ? message ;
  UserData ? data;

  ShopLoginModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message= json['message'] != null ? json['message'] : null;
    data=json['data'] != null ? UserData.fromJson(json['data']) : null ;
  }
}


class UserData{
 late int id;
 late String name ;
 late String email ;
 late String phone ;
 late String image ;
 late String token ;


  UserData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    image=json['image'];
    token=json['token'];
    phone=json['phone'];
  }

}


// model to hold product data

class HomeModel{
 late bool status ;
 late HomeDataModel data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel{
  List<Banners> banners=[];
  List<Products> products=[];

  HomeDataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element)=>{
      banners.add(Banners.fromJson(element))             //ele is a map
    });

    json['products'].forEach((element)=>{
      products.add(Products.fromJson(element)),
    });
  }
}

class Banners {
  late int id;
  late String image;

  Banners.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image=json['image'];
  }
}
class Products {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image ;
  late String name;
  late bool inFavorite;
  late bool inCart;

  Products.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];
  }
}