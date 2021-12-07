import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:light_mart/modules/on_boarding/on_boarding_screen.dart';
import 'package:light_mart/shared/components/constants.dart';
import 'package:light_mart/shared/network/local/cache_helper.dart';
import 'package:light_mart/shared/network/remote/dio_helper.dart';
import 'package:light_mart/shared/styles/themes.dart';
import 'layout/shop_layout.dart';
import 'modules/login/cubit/cubit_observer.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper?.init();

  DioHelper.init();

  Widget widget;

  dynamic isDark = CacheHelper?.getData('isDark') ?? false;

  dynamic onBoarding = CacheHelper.getData('onBoarding');

  token = CacheHelper.getData('token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({Key? key, required this.isDark, required this.startWidget})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: startWidget,
    );
  }
}
