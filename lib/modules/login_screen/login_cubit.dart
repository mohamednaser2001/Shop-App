


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/models.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'login_states.dart';

class ShopAppLoginCubit extends Cubit <ShopAppLoginStates>{
  ShopAppLoginCubit():super(ShopAppLoginInitialState());


  static ShopAppLoginCubit get(context)=> BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({
  required String email,
  required String password,
  }){
    emit(ShopAppLoginLoadingState());
   DioHelper.postData(
       url: 'login',
     data: {
         'email':email,
       'password':password,
     },
   ).then((value) {
    loginModel= ShopLoginModel.fromJson(value.data);
     emit(ShopAppLoginSuccessState(loginModel: loginModel));
   }).catchError((error){
     emit(ShopAppLoginErrorState(error: error.toString()));
   });
  }


  bool isShown = false;
  void changePassword(){
    isShown=!isShown;
    emit(ShopAppLoginChangeState());
  }

}