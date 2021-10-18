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
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

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
    print('home dataaaa');
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel.data.banners[0].image);
      // print(homeModel.status);
      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id: element.inFavorites,
        });
        //print(favorites.toString());
        //print('gat han favorites ');

      });
      //print('gat han HomeData 1');

      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      //print(error.toString());
      //print('gat han2');
      emit(ShopErrorCategoriesStates());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      //print('value of Categories');
      //print(value);
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print(value.data);
      //print('gat han Categories 1');

      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      //print(error.toString());
      //print('gat han2');
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
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print('gat changeFavorites');

      //print(value.data);
      /*if(!changeFavoritesModel.status)
      {
        favorites[productId] = !favorites[productId];
      }*/
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel));
    }).catchError((error) {
      //favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesStates());

      //print('gat changeFavorites error');

    });
  }


  FavoritesModel favoritesModel;

  void getFavorites() {

    print('get favourite');
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      //print('value of Categories');
      //print(value);
      print('han55555555555555');
      favoritesModel = FavoritesModel.fromJson(value.data);
      //print(value.data.toString());
      //print('gat han FAVORITES 1');

      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      //print(error.toString());
      //print('gat error han FAVORITES 2');
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

      print('profile data => ${value}');
      userModel = LoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(ShopSuccessGetUserDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataStates());
    });
  }
}
