

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gluko_repository/gluko_repository.dart';

import '../../home/view/home_page.dart';
import '../../notifications/pushNotification.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginR, this.auto) : super(LoginState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as LoginState);
  }

  LoginRepository loginR;
  PercisteRepository auto;

  Future<ResponseLogin> Login(String email, String password) async{
    emit(state.copywhit(status: LoginStatestatus.loading, email: email, password: password) as LoginState);
    try{
        ResponseLogin response = await loginR.login(email, password);
        print("Respuesta ${response.message}");
        if(response.estatus){
          return response;
        }else{
          emit(state.copywhit(status: LoginStatestatus.success));
          return response;
        }

    }catch(ex){
      emit(state.copywhit(status: LoginStatestatus.success));
      return ResponseLogin(false, "Ocurrio un error");
    }
  }

  Future<void> isAutenticate(BuildContext context)async {
    var response = await auto.isAutenticate();
    if(response){
      LocalNotificationService().initializeService();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage()),
            (Route<dynamic> route) => false,
      );
    }else{
      emit(state.copywhit(status: LoginStatestatus.success));
    }

  }

}
