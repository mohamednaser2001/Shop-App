

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class HomeLayout extends  StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Salla',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> SearchScreen()),
                    );
                  },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                ),
              ],
            ),
            body: cubit.bodyScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index){
                cubit.changeBottomNavBarItem(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon:Icon(Icons.home,),
                  label: 'Products'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.apps,),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.favorite,),
                    label: 'Favorites'
                ),
                BottomNavigationBarItem(
                    icon:Icon(Icons.settings,),
                    label: 'Settings'
                ),
              ],
            ),
          );
        },
    );
  }
}
