import '../../models/models.dart';

abstract class ShopAppRegisterStates{}
class ShopAppRegisterInitialState extends ShopAppRegisterStates{}
class ShopAppRegisterSuccessState extends ShopAppRegisterStates{
  ShopLoginModel loginModel;
  ShopAppRegisterSuccessState({required this.loginModel});
}
class ShopAppRegisterErrorState extends ShopAppRegisterStates{
  String error;
  ShopAppRegisterErrorState({required this.error});
}
class ShopAppRegisterLoadingState extends ShopAppRegisterStates{}
class ShopAppRegisterChangeState extends ShopAppRegisterStates{}