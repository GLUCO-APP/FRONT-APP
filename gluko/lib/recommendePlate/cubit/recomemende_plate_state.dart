part of 'recomemende_plate_cubit.dart';
enum RecomemendePlatestatus{ loading,success,error}
class RecomemendePlateState {
  RecomemendePlateState({
    this.status = RecomemendePlatestatus.loading,
    required this.miposition,
  });
  final RecomemendePlatestatus status;
  final Position miposition;
  RecomemendePlateState copywhit({
    RecomemendePlatestatus? status,
    Position? miposition,
    User? infoUser
  }){
    return RecomemendePlateState(status: status ?? this.status, miposition: miposition?? this.miposition);
  }
}
