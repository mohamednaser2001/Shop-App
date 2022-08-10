




import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/models.dart';
import 'package:shop_app/modules/register_screen/register_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../components/constants.dart';


class ShopAppRegisterCubit extends Cubit <ShopAppRegisterStates>{
  ShopAppRegisterCubit():super(ShopAppRegisterInitialState());


  static ShopAppRegisterCubit get(context)=> BlocProvider.of(context);

  late ShopLoginModel loginModel;            /////

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopAppRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
        'password':password,
      },

    ).then((value) {
      loginModel= ShopLoginModel.fromJson(value.data);           /////
      emit(ShopAppRegisterSuccessState(loginModel: loginModel));
    }).catchError((error){
      print(error.toString()+'from reg cubit');
      emit(ShopAppRegisterErrorState(error: error.toString()));
    });
  }


  bool isShown = false;
  void changePassword(){
    isShown=!isShown;
    emit(ShopAppRegisterChangeState());
  }

}