

import 'package:shop_app/models/models.dart';

abstract class ShopAppLoginStates{}
 class ShopAppLoginInitialState extends ShopAppLoginStates{}
 class ShopAppLoginSuccessState extends ShopAppLoginStates{
 ShopLoginModel loginModel;
 ShopAppLoginSuccessState({required this.loginModel});
 }
 class ShopAppLoginErrorState extends ShopAppLoginStates{
  String error;
  ShopAppLoginErrorState({required this.error});
}
 class ShopAppLoginLoadingState extends ShopAppLoginStates{}
 class ShopAppLoginChangeState extends ShopAppLoginStates{}