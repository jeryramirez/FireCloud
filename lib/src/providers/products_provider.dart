import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductsProvider {
  final String _url = 'https://firegram-5ecf3.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json';
    await http.post(url, body: productModelToJson(product));
    //final response = await http.post(url, body: productModelToJson(product));
    //final decodedData = json.decode(response.body);

    //print(decodedData);

    return true;
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json';
    await http.put(url, body: productModelToJson(product));

    return true;
  }

  Future<List<ProductModel>> getProducts() async {
    final url = '$_url/products.json';
    final response = await http.get(url);

    final List<ProductModel> products = new List();
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    decodedData.forEach((id, product) {
      final temporalProduct = ProductModel.fromJson(product);
      temporalProduct.id = id;

      products.add(temporalProduct);
    });
    return products;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    await http.delete(url);

    return 1;
  }

  Future<String> uploadImage(File image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/oshin/image/upload?upload_preset=rjtfkaa8');

    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('***** some error *****');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['source_url'];
  }
}
