part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState{
  final LoginModel loginModel;
  LoginSuccess({@required this.loginModel});
}
class LoginError extends LoginState{
  final String errorMessage;
  LoginError({
    this.errorMessage
  });
}
class LoginWaiting extends LoginState{}
