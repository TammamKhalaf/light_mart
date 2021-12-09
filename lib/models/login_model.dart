import 'package:light_mart/models/categoriesModel.dart';

import 'homeModel.dart';

class LoginModel {
  late final bool status;
  late final dynamic message;
  late final Data data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final int id;
  late final dynamic name;
  late final dynamic email;
  late final dynamic phone;
  late final dynamic image;
  late final int points;
  late final int credit;
  late final dynamic token;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}

class FavoritesData {
  late int id;
  late ProductModel product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        (json['product'] != null ? new ProductModel.fromJson(json['product']) : null)!;
  }
}
