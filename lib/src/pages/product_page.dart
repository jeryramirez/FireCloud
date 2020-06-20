import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/products_provider.dart';
import 'package:formvalidation/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _saving = false;

  File photo;

  ProductModel product = new ProductModel();

  ProductsProvider productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final ProductModel productData = ModalRoute.of(context).settings.arguments;

    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _sellecctPicture,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePicture,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _showPhoto(),
                _productName(),
                _productPrice(),
                _available(),
                _button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productName() {
    return TextFormField(
      initialValue: product.title,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product Name'),
      onSaved: (value) => product.title = value,
      validator: (value) => value.length <= 3 ? 'add a name ' : null,
    );
  }

  Widget _productPrice() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Product Price'),
      onSaved: (value) => product.price = double.parse(value),
      validator: (value) => isNumber(value) ? null : 'only numbers',
    );
  }

  Widget _button() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: (_saving) ? null : _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    //ejecuta la funcion save de todos los TextFormField con dicha propiedad
    formKey.currentState.save();

    setState(() => _saving = true);

    if (product.id == null) {
      productsProvider.createProduct(product);
    } else {
      productsProvider.editProduct(product);
    }

    // setState(() => _saving = false );
    showSnackbar('saved');

    Navigator.pop(context);
  }

  Widget _available() {
    return SwitchListTile(
      value: product.available,
      title: Text('available'),
      onChanged: (value) => setState(() {
        product.available = value;
      }),
    );
  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 2000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _showPhoto() {
    if (product.photoUrl != null) {
      return Container();
    } else {
      return Image(
        image: AssetImage(photo?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _sellecctPicture() async {
    print('ok');
    photo = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (photo != null) {}
    setState(() {});
  }

  _takePicture() async{
    photo = await ImagePicker.pickImage(source: ImageSource.camera);
  }

}
