import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/products_provider.dart';
import 'package:formvalidation/src/utils/utils.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  ProductModel product = new ProductModel();

  ProductsProvider productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
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
      onPressed: _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    //ejecuta la funcion save de todos los TextFormField con dicha propiedad
    formKey.currentState.save();

    productsProvider.createProduct(product);
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
}
