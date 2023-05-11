part of 'forgetpassword_cubit.dart';
enum Forgetpasswordtatus{ loading,success,error}

class ForgetpasswordState {

  ForgetpasswordState({
    this.status = Forgetpasswordtatus.success
  });

  final Forgetpasswordtatus status;

  Forgetpasswordtatus confirmar(){
    return Forgetpasswordtatus.success;
  }

  ForgetpasswordState copywhit( {
    Forgetpasswordtatus? status
  }){
    return ForgetpasswordState(status: status ?? this.status);
  }
}


