import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as EmergencyState);
  }
}
