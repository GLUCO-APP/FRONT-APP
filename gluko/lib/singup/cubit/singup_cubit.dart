import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit(this.repository, this.emailRepository) : super(SingupState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as SingupState);
  }
  SignUpRepository repository;
  EmailValidateRepository emailRepository;

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

  Future<ResponseValidate> codeValidate (String email) async {
    emit(state.copywhit(status: Singuptatus.loading));
    ResponseValidate response = await emailRepository.validateC(email);
    print(response.code);
    if(response.estatus) {
      emit(state.copywhit(status: Singuptatus.success));
      return response;
    } else {
      emit(state.copywhit(status: Singuptatus.error));
      return response;
    }
  }
}
