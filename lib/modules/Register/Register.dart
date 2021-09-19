
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/Register/cubit/cubit.dart';
import 'package:shop_app/modules/Register/cubit/states.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/shared/components/cmponents.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';


class Register extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context , state)
        {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopLayout()),
                );
                //navigateAndFinish(context: context, widget: ShopLayout());
              });
              /*Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);*/
              showToast(
                text: state.loginModel.message,
                state: ToastStates.SUCCESS,
              );
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopLayout()),
              );*/
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.white38,elevation: 0,),
            body:  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                            style: Theme.of(context).textTheme.headline6),
                        Text('REGISTER now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          label: 'User Name',
                          prefix: Icons.person,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label: 'Email',
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: RegisterCubit.get(context).suffix,
                          /*suffix: isPasswordShow
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                              suffixPressed: () {
                                setState(() {
                                  isPasswordShow = !isPasswordShow;
                                });
                              },*/
                          suffixPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            /*if (formKey.currentState.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }*/
                          },
                          isPassword: RegisterCubit.get(context).isPassword,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          label: 'Phone',
                          prefix: Icons.phone,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          //state is! LoginLoadingState,
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            text: 'register',
                            function: () {
                              if (formKey.currentState.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        /*defaultButton(
                            text: 'Register',
                            function: () {
                              print(emailController.text);
                              print(passwordController.text);
                            },
                          ),*/
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                'Register Now',
                              ),
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
