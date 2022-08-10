

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';

class EditScreen extends  StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
/*
          emailController.text= ShopCubit.get(context).userDataModel==null ? '' : ShopCubit.get(context).userDataModel.data!.email;
          nameController.text=ShopCubit.get(context).userDataModel==null ? '' : ShopCubit.get(context).userDataModel.data!.name;
          phoneController.text=ShopCubit.get(context).userDataModel==null ? '' : ShopCubit.get(context).userDataModel.data!.phone;
*/
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,)),
              title:const Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            body:  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter your name';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0,),
                        TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter your phone';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter email address';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 50.0,),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: MaterialButton(
                            color: Colors.deepOrange,
                            onPressed: (){

                            },
                            child: Row(
                              children: const [
                                Icon(Icons.edit,color: Colors.white,size: 20.0),
                                Expanded(
                                  child: Text(
                                    'update',
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

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
