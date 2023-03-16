part of 'login_cubit.dart';
enum LoginStatestatus{ loading,success,error}
class LoginState {
  LoginState({
    this.status = LoginStatestatus.success
  });

  final LoginStatestatus status;

  LoginStatestatus confirmar(){
    return LoginStatestatus.success;
  }
  
}



