import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';


part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this._report) : super(ReportState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as ReportState);
  }

  ReportPDFRepository _report;

  Future<ResponsePDF> getPDF( int dia) async{
    emit(state.copywhit(status: Reportstatus.loading));
    var field = await _report.getPDF(dia);
    emit(state.copywhit(status: Reportstatus.success));
    return field;
  }

  Future<ResponsePDF> getPDFGraft() async{
    emit(state.copywhit(status: Reportstatus.loading));
    var field = await _report.getPDFGraft();
    emit(state.copywhit(status: Reportstatus.success));
    return field;
  }
}
