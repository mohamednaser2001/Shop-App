

import 'package:shop_app/models/favorites_model/favorites_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavBarItemState extends ShopStates{}
class ShopSuccessState extends ShopStates{}
class ShopLoadingState extends ShopStates{}
class ShopErrorState extends ShopStates{
  String error;
  ShopErrorState({required this.error});
}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  String error;
  ShopErrorCategoriesState({required this.error});
}


class ShopSuccessFavoritesState extends ShopStates{
   ChangeFavoritesModel? model;
  ShopSuccessFavoritesState({required this.model});
}
class ShopSuccessChangeFavoritesState extends ShopStates{}
class ShopErrorFavoritesState extends ShopStates{
  String error;
  ShopErrorFavoritesState({required this.error});
}


class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{
  String error;
  ShopErrorGetFavoritesState({required this.error});
}





class ShopSuccessUpdateUserDataState extends ShopStates{}
class ShopLoadingUpdateUserDataState extends ShopStates{}
class ShopErrorUpdateUserDataState extends ShopStates{
  String error;
  ShopErrorUpdateUserDataState({required this.error});
}



class ShopSuccessGetUserDataState extends ShopStates{}
class ShopLoadingGetUserDataState extends ShopStates{}
class ShopErrorGetUserDataState extends ShopStates{
  String error;
  ShopErrorGetUserDataState({required this.error});
}