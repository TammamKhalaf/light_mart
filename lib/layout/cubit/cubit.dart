import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_mart/layout/cubit/states.dart';
import 'package:light_mart/models/categoriesModel.dart';
import 'package:light_mart/models/change_favorites_model.dart';
import 'package:light_mart/models/favorites_model.dart';
import 'package:light_mart/models/homeModel.dart';
import 'package:light_mart/models/login_model.dart';
import 'package:light_mart/modules/categories/categories_screen.dart';
import 'package:light_mart/modules/favorites/favorites_screen.dart';
import 'package:light_mart/modules/products/products_screen.dart';
import 'package:light_mart/modules/settings/settings_screen.dart';
import 'package:light_mart/shared/components/constants.dart';
import 'package:light_mart/shared/network/end_points.dart';
import 'package:light_mart/shared/network/remote/dio_helper.dart';

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

  HomeModel? homeModel;
  Map<int, bool?> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(language: 'en', token: token, query: null, url: HOME)
        .then((value) {
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });

      print(favorites);

      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStates(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(language: 'en', url: GET_CATEGORIES).then((value) {
      print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStates(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !(favorites[productId])!;
    emit(ShopSuccessChangeFavoritesStates());
    print('TOKEN IS ' + token);
    DioHelper.postData('en', token, {'': ''},
        url: FAVORITES,
        data: {
          'product_id': productId,
        }).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !(favorites[productId])!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesStates());
    }).catchError((error) {
      favorites[productId] = !(favorites[productId])!;
      emit(ShopErrorChangeFavoritesStates(error));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    DioHelper.getData(
      language: 'en',
      url: FAVORITES,
      token: token,
    ).then((value) {
      emit(ShopLoadingGetFavoritesStates());
      favoritesModel = FavoritesModel.fromJson(value.data);
      print('favorites model ' + value.data.toString());
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesStates(error));
    });
  }

  LoginModel? userModel;

  void getUserData() {
    DioHelper.getData(
      language: 'en',
      url: PROFILE,
      token: token,
    ).then((value) {
      emit(ShopLoadingUserDataStates());
      userModel = LoginModel.fromJson(value.data);
      print('PROFILE model ' + value.data.toString());
      emit(ShopSuccessUserDataStates(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStates(error));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    DioHelper.putData(
        language: 'en',
        token: token,
        url: UPDATE_PROFILE,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        }).then((value) {
      emit(ShopLoadingUpdateUserDataStates());
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataStates(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataStates(error.toString()));
    });
  }
}
