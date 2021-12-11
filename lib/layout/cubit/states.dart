import 'package:light_mart/models/login_model.dart';
import 'package:light_mart/models/user_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {
  final String error;

  ShopErrorHomeDataStates(this.error);

}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {
  final String error;

  ShopErrorCategoriesStates(this.error);

}

class ShopSuccessChangeFavoritesStates extends ShopStates {}

class ShopErrorChangeFavoritesStates extends ShopStates {
  final String error;

  ShopErrorChangeFavoritesStates(this.error);

}

class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {
  final String error;
  ShopErrorGetFavoritesStates(this.error);
}


class ShopLoadingUserDataStates extends ShopStates {}

class ShopSuccessUserDataStates extends ShopStates {
  final LoginModel? userModel;

  ShopSuccessUserDataStates(this.userModel);
}

class ShopErrorUserDataStates extends ShopStates {
  final String error;
  ShopErrorUserDataStates(this.error);
}