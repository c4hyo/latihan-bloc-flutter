import 'package:bloc_tutorial/bloc/login_bloc/login_bloc.dart';
import 'package:bloc_tutorial/model/login.dart';
import 'package:bloc_tutorial/ui/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  LoginBloc _loginBloc;
  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc,LoginState>(
        bloc: _loginBloc,
        listener: (context,state){
          if(state is LoginSuccess){
            Fluttertoast.showToast(msg: "Sukses");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
          }
          if(state is LoginError){
            Fluttertoast.showToast(msg: state.errorMessage);
          }
        },
        child: Container(
          child: Center(
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: _loginBloc,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        LoginModel loginModel = LoginModel(
                          password: "cityslicka",
                          email: "eve.holt@reqres.in"
                        );
                        _loginBloc.add(Login(loginData: loginModel));
                      },
                      child: (state is LoginWaiting)?CircularProgressIndicator(backgroundColor: Colors.black,):Text('Login'),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}