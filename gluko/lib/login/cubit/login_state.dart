part of 'login_cubit.dart';
enum LoginStatestatus{ loading,success,error}
class LoginState {
  LoginState({
    this.email = "",
    this.pasword = "",
    this.status = LoginStatestatus.loading
  });

  final LoginStatestatus status;
  final email;
  final pasword;

  LoginStatestatus Ejecutar(){
    return LoginStatestatus.loading;
  }
  LoginStatestatus confirmar(){
    return LoginStatestatus.success;
  }

  LoginState copywhit({
    LoginStatestatus? status,
    String? email,
    String? password,
    ResponseLogin? response
  }){
    return LoginState(status: status ?? this.status, email: email ?? this.email, pasword: password ?? this.pasword);
  }
  
}



