import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/logIn_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class LogInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(
        body: Stack(
          children: <Widget>[
            _logInBackground(context),
            _logInForm(context)
          ],
        )
      )
    );
  }

  Widget _logInBackground(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height *0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        background,

        Container(

          padding: EdgeInsetsDirectional.only(top: size.height *0.1),

          child: Column(
            children: <Widget>[
              Icon(Icons.account_circle, color: Colors.white, size: 80.0,),
              SizedBox( width: double.infinity, height: size.height *0.01),
              Text('FV APP', style: TextStyle( color: Colors.white, fontSize: 18),)
              
            ],
          ),
        )
      ],
    );

  }

  Widget _logInForm(BuildContext context) {

    final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: size.height *0.25,
            )
          ),


          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Log in', style: TextStyle(fontSize: 18.0),),
                SizedBox(height: 50,),
                _email(bloc),
                _password(bloc),
                _button(bloc)
              ],
            ),
          ),
          Text('Did you forget your password ?', style: TextStyle(color: Colors.grey),),
          SizedBox(height: 100,)
        ],
      ),
    );

  }

  Widget _email(LogInBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // print(snapshot.data);
        return Container(

          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 20),

          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
              labelText: 'Email Address',
              hintText: 'example@gmail.com',
              errorText: snapshot.error,
              counterText: snapshot.data
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );


  }

  Widget _password(LogInBloc bloc) {


    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        print(snapshot.data);
        return Container(

          margin: EdgeInsets.symmetric(vertical:20),
          padding: EdgeInsets.symmetric(horizontal: 20),

          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
              labelText: 'Password',
              errorText: snapshot.error,
              counterText: snapshot.data
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );


  }

  Widget _button(LogInBloc bloc) {

    return StreamBuilder(
      stream: bloc.formValidateStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 125),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          color: Colors.deepPurple,

          child: Container(
            child: Text('Sing In', style: TextStyle(color: Colors.white)),
          ),
          onPressed: snapshot.hasData == true ? () => logIn(context, bloc) : null,
          
        );
      }
      
    );

  }

  logIn(BuildContext context, LogInBloc bloc) {
    print(bloc.email);
    
    print(bloc.password);
    Navigator.pushReplacementNamed(context, 'home');

  }
}