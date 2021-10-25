import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/cateogries/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/cmponents.dart';
import 'package:shop_app/shared/network/end_poient.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  static String token = CacheHelper.getData(key: 'token');

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavStates());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    //print('home dataaaa');
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      //print(token + 'from get home Data');
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
        //print(favorites.toString());
      });

      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      //print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      emit(ShopErrorHomeDataStates());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesStates());

    DioHelper.pastData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      print('value => ${value}');
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print('gat changeFavorites');
      //print(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      //print(token + 'from get Favorites');
      //print(value);
      favoritesModel = FavoritesModel.fromJson(value.data);
      for (var product in favoritesModel.data.data) {
        favorites.addAll({
          product.product.id: true,
        });
      }

      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesStates());
    });
  }

  LoginModel userModel;

  void getUserModel() {
    emit(ShopLoadingGetUserDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      //print('profile data => ${value}');
      userModel = LoginModel.fromJson(value.data);
      //print(userModel.data.name);
      emit(ShopSuccessGetUserDataStates(userModel));
    }).catchError((error) {
      emit(ShopErrorGetUserDataStates());
    });
  }

  void updateUserModel({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      //print('profile data => ${value}');
      userModel = LoginModel.fromJson(value.data);
      //print(userModel.data.name);
      emit(ShopSuccessUpdateUserStates(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUserStates());
    });
  }
}
