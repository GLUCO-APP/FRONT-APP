part of 'report_cubit.dart';
enum Reportstatus{ loading,success,error}
class ReportState {
  ReportState({
    this.status = Reportstatus.success
  });

  final Reportstatus status;

  Reportstatus confirmar(){
    return Reportstatus.success;
  }
  ReportState copywhit({
    Reportstatus? status,
  }){
    return ReportState(status: status ?? this.status);
  }
}

