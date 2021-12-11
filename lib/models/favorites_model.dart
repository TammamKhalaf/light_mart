class FavoritesModel
{
  late bool status;
  late dynamic message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
    // if (json['data'] != null) {
    //   data = Data.fromJson(json['data']);
    // } else {
    //
    // }
  }
}

class Data {
  late dynamic currentPage;
  late List<FavoritesData> data;
  late dynamic firstPageUrl;
  late dynamic from;
  late dynamic lastPage;
  late dynamic lastPageUrl;
  late dynamic nextPageUrl;
  late dynamic path;
  late dynamic perPage;
  late dynamic prevPageUrl;
  late dynamic to;
  late dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoritesData>[];
      json['data'].forEach((v) {
        data.add(FavoritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
  late int id;
  late Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late dynamic image;
  late dynamic name;
  late dynamic description;

  Product(
      {required this.id,
        this.price,
        this.oldPrice,
        required this.discount,
        required this.image,
        required this.name,
        required this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}