class ProductModel {
  late int id;
  late String title;
  late num price;
  late String description;
  late String category;
  late String image;
  late num rate;
  late int count;

//create constructor fromjson to get data from backend
  ProductModel.fromjson(Map json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rate = json['rating']['rate'];
    count = json['rating']['count'];
  }
}
