part of 'history_report_cubit.dart';
enum HistoryReportstatus{ loading,success,error}
class HistoryReportState {
  HistoryReportState({
    this.status = HistoryReportstatus.success
  });

  final HistoryReportstatus status;

  HistoryReportState copywhit({
    HistoryReportstatus? status,
  }){
    return HistoryReportState(status: status ?? this.status);
  }
}

