part of 'emergency_cubit.dart';
enum Emergencystatus{ loading,success,error}
class EmergencyState {
  EmergencyState({
    this.status = Emergencystatus.loading,
    required this.infoUser ,
  });

  final Emergencystatus status;
  final User infoUser;

  Emergencystatus confirmar(){
    return Emergencystatus.success;
  }
  EmergencyState copywhit({
    Emergencystatus? status,
    User? infoUser
  }){
    return EmergencyState(status: status ?? this.status,infoUser: infoUser ?? this.infoUser);
  }
}

