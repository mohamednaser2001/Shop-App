

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/modules/edit_screen/edit_screen.dart';

import '../../shared/network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopErrorGetUserDataState)print(state.error.toString());
        },
        builder: (context,state){
          var model = ShopCubit.get(context).userDataModel;
          String email =model==null ? '' : model.data!.email;
          String name =model==null ? '' : model.data!.name;
          String phone =model==null ? '' : model.data!.phone;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 40.0,),
                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: NetworkImage('https://student.valuxapps.com/storage/uploads/products/1638738391UiO3W.22.jpg'),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    ShopCubit.get(context).userDataModel!.data!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40.0,),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email_outlined,color: Colors.grey,),
                          SizedBox(width: 16.0),
                          Text(
                            email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:const TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18.0,),
                      Row(
                        children: [
                          const Icon(Icons.phone,color: Colors.grey,),
                          SizedBox(width: 16.0),
                          Text(
                            phone,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:const TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: MaterialButton(
                      color: Colors.deepOrange,
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>EditScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.edit,color: Colors.white,size: 20.0),
                          Expanded(
                            child: Text(
                              'Edit Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: MaterialButton(
                      color: Colors.deepOrange,
                      onPressed: (){
                        CacheHelper.removeData(key: 'token').then((value) {
                          if(value==true){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context)=> LoginScreen()),
                                    (route) => false
                            );
                          }
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.logout,color: Colors.white,size: 20.0),
                          Expanded(
                            child: Text(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
