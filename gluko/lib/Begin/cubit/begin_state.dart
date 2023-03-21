part of 'begin_cubit.dart';
enum Beginstatus{ loading,success,error}
class BeginState {
  BeginState({
    this.status = Beginstatus.success
  });

  final Beginstatus status;

  Beginstatus confirmar(){
    return Beginstatus.success;
  }

 }

