import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgetpassword_state.dart';

class ForgetpasswordCubit extends Cubit<ForgetpasswordState> {
  ForgetpasswordCubit() : super(ForgetpasswordState());

  Future<void> Iniciar() async{
    emit(state.confirmar() as ForgetpasswordState);
  }
}
