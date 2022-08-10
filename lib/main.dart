import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/bloc_observer/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'components/constants.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/onboarding_screen.dart';
import 'modules/register_screen/register_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding'); // ?? false ;
  token = CacheHelper.getData(key: 'token');
  print(token);
   Widget widget;
  if(onBoarding != null){
    if(token!=null){
      widget = HomeLayout();
    }
    else {
      widget = LoginScreen();
    }
  }
  else {
    widget = OnBoardingScreen();
  }


  BlocOverrides.runZoned(
        ()=>runApp(MyApp(startWidget: widget)),
        blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit()..getProductsData()..getCategoriesData()..getFavoritesData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.deepOrange,
        ),
        home: HomeLayout(),    // startWidget,
      ),
    );
  }
}
