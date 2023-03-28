import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculateinsulin_state.dart';

class CalculateinsulinCubit extends Cubit<CalculateinsulinState> {
  CalculateinsulinCubit() : super(CalculateinsulinState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as CalculateinsulinState);
  }
}
