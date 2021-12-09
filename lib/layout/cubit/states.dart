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