import 'package:flutter/foundation.dart';

class HomeModel {
  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final dynamic message;
  late final Data data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = '';
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.banners,
    required this.products,
    required this.ad,
  });
  late final List<Banner> banners;
  late final List<ProductModel> products;
  late final String ad;

  Data.fromJson(Map<String, dynamic> json){
    banners = List.from(json['banners']).map((e)=>Banner.fromJson(e)).toList();
    products = List.from(json['products']).map((e)=>ProductModel.fromJson(e)).toList();
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banners'] = banners.map((e)=>e.toJson()).toList();
    _data['products'] = products.map((e)=>e.toJson()).toList();
    _data['ad'] = ad;
    return _data;
  }
}

class Banner {
  Banner({
    required this.id,
    required this.image,
    required this.category,
    required this.product,
  });
  late final num id;
  late final dynamic image;
  late final Category? category;
  late final ProductModel? product;

  Banner.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['category'] = category;
    _data['product'] = product;
    return _data;
  }
}

class ProductModel {
  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });
  late final dynamic id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final dynamic image;
  late final dynamic name;
  late final dynamic description;
  late final List<dynamic> images;
  late final bool inFavorites;
  late final bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['old_price'] = oldPrice;
    _data['discount'] = discount;
    _data['image'] = image;
    _data['name'] = name;
    _data['description'] = description;
    _data['images'] = images;
    _data['in_favorites'] = inFavorites;
    _data['in_cart'] = inCart;
    return _data;
  }
}