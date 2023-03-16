import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit() : super(SingupState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as SingupState);
  }
}
