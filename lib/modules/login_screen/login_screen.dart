

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login_screen/login_states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../components/components.dart';
import 'login_cubit.dart';

class LoginScreen extends  StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopAppLoginCubit(),
      child: BlocConsumer<ShopAppLoginCubit,ShopAppLoginStates>(
        listener: (context, state){
          if(state is ShopAppLoginSuccessState){
            if(state.loginModel.status){
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
          if(state is ShopAppLoginErrorState){
            print(state.error.toString());
          }
        },
        builder: (context, state){
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
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
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon:const Icon(
                               Icons.lock_outline_rounded,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                ShopAppLoginCubit.get(context).changePassword();
                              },
                              icon: Icon(
                                ShopAppLoginCubit.get(context).isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                              ),
                            ),

                          ),
                          obscureText:ShopAppLoginCubit.get(context).isShown ? false : true,
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
                            condition: state is! ShopAppLoginLoadingState,
                            builder:(context)=> MaterialButton(
                              onPressed:(){
                                if(formKey.currentState!.validate()){
                                  ShopAppLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'Login',
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
                              'Not have an account! ',
                            ),
                            TextButton(
                              child:const Text(
                                  'Register'
                              ),
                              onPressed: (){
                                Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context)=> RegisterScreen(),
                                ),
                                );
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
