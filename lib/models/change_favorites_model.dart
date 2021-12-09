class ChangeFavoritesModel{
  late bool status;
  late dynamic message;

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }

}