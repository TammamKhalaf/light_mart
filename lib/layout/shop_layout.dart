import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_mart/modules/login/login_screen.dart';
import 'package:light_mart/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light Mart'),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData('token').then((value) {
            if (value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            } else {}
          });
        },
        child: Text('Sign out!'),
      ),
    );
  }
}
