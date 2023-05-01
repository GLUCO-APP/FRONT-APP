part of 'history_report_cubit.dart';
enum HistoryReportstatus{ loading,success,error}
class HistoryReportState {
  HistoryReportState({
    this.status = HistoryReportstatus.loading,
    required this.repos,
  });

  final HistoryReportstatus status;
  final List<ReportDetail> repos;

  HistoryReportState copywhit({
    HistoryReportstatus? status,
    List<ReportDetail>? repos
  }){
    return HistoryReportState(status: status ?? this.status, repos: repos ?? this.repos);
  }
}

