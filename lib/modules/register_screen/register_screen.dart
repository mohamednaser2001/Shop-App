

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/register_screen/register_cubit.dart';
import 'package:shop_app/modules/register_screen/register_states.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../layout/home_layout.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends  StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> ShopAppRegisterCubit(),
      child: BlocConsumer<ShopAppRegisterCubit,ShopAppRegisterStates>(
        listener: (context,state){
          if(state is ShopAppRegisterSuccessState){
            print(state.loginModel.status);
            print(state.loginModel.message);
            print('==============================');
            if(state.loginModel.status==true){
              CacheHelper.saveData(key: 'token', value:state.loginModel.data!.token).then((value) {
                if(value==true){
                  token = state.loginModel.data!.token;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context)=> HomeLayout()),
                          (route) => false
                  );
                }
              });
            }else{
              showToast(text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
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
                              return 'Enter name';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
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
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
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
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon:const Icon(
                              Icons.lock_outline_rounded,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                ShopAppRegisterCubit.get(context).changePassword();
                              },
                              icon: Icon(
                                ShopAppRegisterCubit.get(context).isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                              ),
                            ),

                          ),
                          obscureText:ShopAppRegisterCubit.get(context).isShown ? false : true,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 30.0,),
                        Container(
                          color: Colors.deepOrange,
                          width: double.infinity,
                          height: 40,
                          child: ConditionalBuilder(
                            condition: state is! ShopAppRegisterLoadingState,
                            builder:(context)=> MaterialButton(
                              onPressed:(){
                                if(formKey.currentState!.validate()){
                                  ShopAppRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }

                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.white,)) ,
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account! ',
                            ),
                            TextButton(
                              child:const Text(
                                  'Login'
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ],
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
