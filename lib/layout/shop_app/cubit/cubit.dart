import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
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

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      pipe(value.data);
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel.data.banners[0].image);
      print(homeModel.status);
      print('gat han1');

      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      print('gat han2');
      emit(ShopErrorHomeDataStates());
    });
  }
}
