import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_mart/layout/cubit/states.dart';
import 'package:light_mart/models/homeModel.dart';
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

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(language: 'en', token: token, query: null, url: HOME)
        .then((value) {
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStates(error.toString()));
    });
  }
}
