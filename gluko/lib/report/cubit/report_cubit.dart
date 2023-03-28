import 'package:bloc/bloc.dart';


part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as ReportState);
  }
}
