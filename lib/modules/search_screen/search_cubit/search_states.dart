

abstract class ShopAppSearchStates {}
class ShopAppInitialSearchState extends ShopAppSearchStates{}
class ShopAppLoadingSearchState extends ShopAppSearchStates{}
class ShopAppSuccessSearchState extends ShopAppSearchStates{}
class ShopAppErrorSearchState extends ShopAppSearchStates{
  String error ;
  ShopAppErrorSearchState(this.error);
}