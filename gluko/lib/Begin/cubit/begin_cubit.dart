import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'begin_state.dart';

class BeginCubit extends Cubit<BeginState> {
  BeginCubit() : super(BeginState());

  Future<void> Iniciar() async{
    emit(state.confirmar() as BeginState);
  }
}
