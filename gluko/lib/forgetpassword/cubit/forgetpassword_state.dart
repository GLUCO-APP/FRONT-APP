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
}


