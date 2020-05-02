import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/model/login.dart';
import 'package:bloc_tutorial/network/api_provider.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is Login){
      yield* _loginAction(event.loginData);
    }
  }
}
Stream<LoginState> _loginAction(LoginModel loginModels) async*{
  ApiProvider _apiProvider = ApiProvider();

  yield LoginWaiting();
  try{
    LoginModel data = await _apiProvider.login(loginModels);
    yield LoginSuccess(loginModel: data);
  }catch(e){
    yield LoginError(errorMessage: "pengguna tidak ditemukan");
  }
}