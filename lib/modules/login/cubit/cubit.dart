import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_poient.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    print('login from main');
    emit(LoginLoadingState());
    DioHelper.pastData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      print("gat hana");

      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePasswordVisibilityState());
  }
}
