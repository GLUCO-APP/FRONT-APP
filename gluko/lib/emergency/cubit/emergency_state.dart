part of 'emergency_cubit.dart';
enum Emergencystatus{ loading,success,error}
class EmergencyState {
  EmergencyState({
    this.status = Emergencystatus.success
  });

  final Emergencystatus status;

  Emergencystatus confirmar(){
    return Emergencystatus.success;
  }
}

