import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit(this.repository, this.emailRepository, this.insulinRepository) : super(SingupState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as SingupState);
  }
  allinsulinRepository insulinRepository;
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

  Future<void> listInsulin () async{
    try{
      List<Insulin> insulinas = await insulinRepository.getInsulin();
      emit(state.copywhit(status: Singuptatus.success, insulinas: insulinas));
    }catch (ex){
      emit(state.copywhit(status: Singuptatus.error));
    }

  }
}
