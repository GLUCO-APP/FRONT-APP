import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'history_report_state.dart';

class HistoryReportCubit extends Cubit<HistoryReportState> {
  HistoryReportCubit(this.report) : super(HistoryReportState(repos:[],infoUser:User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "", "")));

  allReportRepository report;

  Future<void> getReports() async{
    try{
      var reports = await report.getAllReport();
      var user = await infoUserRepository().getInfoUser();
      emit(state.copywhit(status: HistoryReportstatus.success, repos: reports,infoUser: user));
      print(reports);
    }catch(ex){
      emit(state.copywhit(status: HistoryReportstatus.success, repos: []));
    }

  }
  List<ReportDetail> reports(){
    return state.repos;
  }
  User infoUser(){
    return state.infoUser;
  }
}
