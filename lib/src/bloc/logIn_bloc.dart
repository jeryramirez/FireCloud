import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:formvalidation/src/bloc/validators.dart';

class LogInBloc with Validators {


  //Listeners
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //get set
  String get email => _emailController.value;
  String get password => _passwordController.value;

  //input
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  //output
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  //combine stream
  Stream<bool> get formValidateStream => CombineLatestStream.combine2(emailStream, passwordStream, (email, password) => true );

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}