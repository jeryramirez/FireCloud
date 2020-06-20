import 'dart:convert';

import 'package:formvalidation/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _url = 'https://firegram-5ecf3.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json';
    final response = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }
}
