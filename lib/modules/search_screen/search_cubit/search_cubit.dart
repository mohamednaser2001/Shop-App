

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../components/constants.dart';

class ShopAppSearchCubit extends Cubit<ShopAppSearchStates>{
  ShopAppSearchCubit():super (ShopAppInitialSearchState());
  static ShopAppSearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearch(String text){
    emit(ShopAppLoadingSearchState());
    DioHelper.postData(
        url:SEARCH ,
        data: {
          'text':text,
        },
      token: token,
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopAppSuccessSearchState());
    }).catchError((error){
      print(error.toString()+' from search cubit');
      emit(ShopAppErrorSearchState(error));
    });
  }


}