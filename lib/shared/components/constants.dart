import 'package:flutter/material.dart';
import 'package:light_mart/modules/login/login_screen.dart';
import 'package:light_mart/shared/network/local/cache_helper.dart';

void signout(context){
      CacheHelper.removeData('token').then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
                  (Route<dynamic> route) => false);
        }
      });
}

dynamic token = '';