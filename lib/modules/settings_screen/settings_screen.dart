

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/modules/edit_screen/edit_screen.dart';

import '../../shared/network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40.0,),
            const CircleAvatar(
              radius: 72,
              backgroundColor: Colors.deepOrange,
              child: CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage(
                  'assets/images/default_profile_image.jpg',
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Text(
              ShopCubit.get(context).userNameInCubit?? userName!,
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
                      ShopCubit.get(context).userDataModel?.data?.email?? userEmail!,
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
                      ShopCubit.get(context).userDataModel?.data?.phone?? userPhone!,
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
  }
}
