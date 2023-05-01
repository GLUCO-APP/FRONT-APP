import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'history_report_state.dart';

class HistoryReportCubit extends Cubit<HistoryReportState> {
  HistoryReportCubit(this.report) : super(HistoryReportState(repos:[]));

  allReportRepository report;

  Future<void> getReports() async{
    var reports = await report.getAllReport();
    emit(state.copywhit(status: HistoryReportstatus.success, repos: reports));
    print(reports);
  }
  List<ReportDetail> reports(){
    return state.repos;
  }
}
