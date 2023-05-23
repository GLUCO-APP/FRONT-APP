part of 'begin_cubit.dart';
enum Beginstatus{ loading,success,error}
class BeginState {
  BeginState({
    this.status = Beginstatus.loading,
    required this.actual,
    required this.recomend,
    this.recomendS = false
  });

  final List<PlateRecomend> recomend;
  final Beginstatus status;
  final ActualStateDetail actual;
  final bool recomendS;

  Beginstatus confirmar(){
    return Beginstatus.success;
  }

  BeginState copywhit({
    Beginstatus? status,
    ActualStateDetail? actual,
    List<PlateRecomend>? recomend,
    bool? recomendS
  }){
    return BeginState(status: status ?? this.status, actual: actual ?? this.actual, recomend: recomend ?? this.recomend, recomendS: recomendS ?? this.recomendS);
  }

 }

