part of 'calculateinsulin_cubit.dart';
enum Calculateinsulinstatus{ loading,success,error}
class CalculateinsulinState {
  CalculateinsulinState({
    this.status = Calculateinsulinstatus.success
  });

  final Calculateinsulinstatus status;

  Calculateinsulinstatus confirmar(){
    return Calculateinsulinstatus.success;
  }
}

