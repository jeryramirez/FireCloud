import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/logIn_bloc.dart';

class Provider extends InheritedWidget {
  
  static Provider _instace;

  factory Provider({Key key, Widget child}) {
    if (_instace == null) {
      _instace = new Provider._internal(key: key, child: child);
    }
    return _instace;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final logInBloc = LogInBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LogInBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).logInBloc;
  }
}
