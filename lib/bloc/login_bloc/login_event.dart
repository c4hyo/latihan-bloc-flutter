part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class Login extends LoginEvent{
  final LoginModel loginData;
  Login({@required this.loginData});
}