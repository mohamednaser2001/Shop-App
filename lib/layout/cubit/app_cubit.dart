


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/models/categories_models/categories_model.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/models/models.dart';
import 'package:shop_app/modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/modules/product_screen/product_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../components/constants.dart';
import '../../modules/categories_screen/categories_screen.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit(): super (ShopInitialState());

  static ShopCubit get(context)=> BlocProvider.of(context);

  List<Widget> bodyScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  int currentIndex=0;
  void changeBottomNavBarItem(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavBarItemState());
  }

   HomeModel? model;
   Map<int,bool> favorites={};
  void getProductsData(){
    emit(ShopLoadingState());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value) {
         model = HomeModel.fromJson(value.data);
         model!.data.products.forEach((element) {
           favorites.addAll({
             element.id:element.inFavorite,
           });
         });
        emit(ShopSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorState(error: error.toString(),));
    });
  }

   CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
        url: CATEGORIES,
        token: token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print('error in get categories data ${error.toString()}');
      emit(ShopErrorCategoriesState(error: error));
    });
  }


  ChangeFavoritesModel? favoritesModel;
  void changeFavorites(int productId){
    if(favorites[productId]==true) {
      favorites[productId]=false;
    } else {
      favorites[productId]=true;
    }
    emit(ShopSuccessChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data:{'product_id':productId},
        token: token,
    ).then((value){
      favoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!favoritesModel!.status){
        if(favorites[productId]==true) {
          favorites[productId]=false;
        } else {
          favorites[productId]=true;
        }
      }else {
        getFavoritesData();
      }
      emit(ShopSuccessFavoritesState(model: favoritesModel));
    }).catchError((error){
      if(!favoritesModel!.status){
        if(favorites[productId]==true) {
          favorites[productId]=false;
        } else {
          favorites[productId]=true;
        }
      }else {
        getFavoritesData();
      }
      emit(ShopErrorFavoritesState(error: error));
    });
  }


  FavoritesModel? favModel;
  void getFavoritesData(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print('error in get favorites data ${error.toString()}');
      emit(ShopErrorGetFavoritesState(error: error));
    });
  }

}
