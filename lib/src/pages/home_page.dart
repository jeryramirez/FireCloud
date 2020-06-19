import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(),
      floatingActionButton: _button(context),
    );
  }

  Widget _button(BuildContext context) {
    return FloatingActionButton(
      child: Icon (Icons. add),
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }
}