import 'package:bloc_tutorial/bloc/login_bloc/login_bloc.dart';
import 'package:bloc_tutorial/bloc/post_bloc/post_bloc.dart';
// import 'package:bloc_tutorial/ui/page/gesture.dart';
// import 'package:bloc_tutorial/ui/page/home.dart';
import 'package:bloc_tutorial/ui/page/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create:(BuildContext context) => PostBloc()),
        BlocProvider<LoginBloc>(create: (BuildContext context)=> LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}

