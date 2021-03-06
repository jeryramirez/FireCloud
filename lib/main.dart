import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';

import 'src/pages/login_page.dart';
import 'src/pages/product_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login' : (BuildContext context)  => LogInPage(),
          'home' : (BuildContext context)   => HomePage(),
          'product': (BuildContext context) => ProductPage()
        },
        
      ),
    );
    
    
    
    
  }
}