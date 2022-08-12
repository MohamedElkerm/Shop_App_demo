class ChangeFavoritesModel{
  bool status;
  String message;
  Data data;
  ChangeFavoritesModel.fromJson(json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data{
  int id;
  Product product;
  Data.fromJson(json){
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product{
  int id;
  var price;
  var old_price;
  var discount;
  String image;

  Product.fromJson(json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
