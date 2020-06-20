import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  ProductsProvider _productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _listOfProducts(),
      floatingActionButton: _button(context),
    );
  }

  Widget _button(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _listOfProducts() {
    return FutureBuilder(
      future: _productsProvider.getProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;

          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) => _item(context, products[i]));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _item(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent,
      ),
      onDismissed: (direcction) {
        _productsProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text('${product.title} - ${product.price}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'product'),
      ),
    );
  }
}
