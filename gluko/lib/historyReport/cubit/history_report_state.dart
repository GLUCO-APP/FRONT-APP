part of 'history_report_cubit.dart';
enum HistoryReportstatus{ loading,success,error}
class HistoryReportState {
  HistoryReportState({
    this.status = HistoryReportstatus.loading,
    required this.repos,
    required this.infoUser
  });

  final HistoryReportstatus status;
  final List<ReportDetail> repos;
  final User infoUser;
  HistoryReportState copywhit({
    HistoryReportstatus? status,
    List<ReportDetail>? repos,
    User? infoUser
  }){
    return HistoryReportState(status: status ?? this.status, repos: repos ?? this.repos, infoUser: infoUser ?? this.infoUser);
  }
}

