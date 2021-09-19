import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

class ShopChangeFavoritesStates extends ShopStates {}

class ShopSuccessChangeFavoritesStates extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopErrorChangeFavoritesStates extends ShopStates {}



class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {}


class ShopLoadingGetUserDataStates extends ShopStates {}

class ShopSuccessGetUserDataStates extends ShopStates {}

class ShopErrorGetUserDataStates extends ShopStates {}

/*



class ShopInitialStates extends ShopStates{}
*/
