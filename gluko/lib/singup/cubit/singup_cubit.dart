import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit(this.repository) : super(SingupState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as SingupState);
  }
  SignUpRepository repository;

  Future<ResponseSignUp> signUp (User usuario) async {
    emit(state.copywhit(status: Singuptatus.loading));
    ResponseSignUp response = await repository.signUp(usuario);
    print(response.message);
    if (response.estatus) {
      emit(state.copywhit(status: Singuptatus.success));
      return response;
    } else {
      emit(state.copywhit(status: Singuptatus.success));
      return response;
    }
  }
}
