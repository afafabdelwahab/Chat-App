
abstract class AuthEvents{}
class LoginEvent extends AuthEvents{
  final String email;
  final String password;
  LoginEvent({required this.email,required this.password});
}
class RegisterEvent extends AuthEvents{
  final String email;
  final String password;
  RegisterEvent({required this.email,required this.password});
}