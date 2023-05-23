part of 'calculateinsulin_cubit.dart';
enum Calculateinsulinstatus{ loading,success,error}
class CalculateinsulinState {
  CalculateinsulinState({
    this.status = Calculateinsulinstatus.loading,
    required this.infoUser ,
  });

  final Calculateinsulinstatus status;
  final User infoUser;

  Calculateinsulinstatus confirmar(){
    return Calculateinsulinstatus.loading;
  }

  CalculateinsulinState copyWith({
    Calculateinsulinstatus? status,
    User? infoUser
  }) {
    return CalculateinsulinState(
      status: status ?? this.status,infoUser: infoUser ?? this.infoUser
    );
  }
}

