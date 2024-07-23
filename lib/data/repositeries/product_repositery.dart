import 'dart:convert';
import 'package:fake_store/data/models/product_model.dart';
import 'package:http/http.dart';

class ProductRepositery {
//get all list product model
  static Future<List<ProductModel>> getAllProducts() async {
//get request mn el endpoint for product to get data
    var response = await get(Uri.parse('https://fakestoreapi.com/products'));
    // to get list of oppjects (body)
    var data = jsonDecode(response.body);
    List<ProductModel> products_list = [];
    // create for loop to get all elements in list
    for (var element in data) {
      //create model for every map mn no3 productModel
      ProductModel model = ProductModel.fromjson(element);
      // put model in product_list
      products_list.add(model);
    }
    print(data);
    print(products_list);
    return products_list;
  }
}
