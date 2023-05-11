import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'forgetpassword_state.dart';

class ForgetpasswordCubit extends Cubit<ForgetpasswordState> {
  ForgetpasswordCubit(this.emailRepository, this.changeRepository, this.persisteRepository) : super(ForgetpasswordState());

  Future<void> Iniciar() async{
    emit(state.confirmar() as ForgetpasswordState);
  }

  EmailValidateRepository emailRepository;
  ResetPasswordRepository changeRepository;
  PercisteRepository persisteRepository;

  Future<ResponseValidate> codeValidate (String email) async {
    emit(state.copywhit(status: Forgetpasswordtatus.loading));
    ResponseValidate response = await emailRepository.validateC(email);
    print(response.code);
    if(response.estatus) {
      emit(state.copywhit(status: Forgetpasswordtatus.success));
      return response;
    } else {
      emit(state.copywhit(status: Forgetpasswordtatus.error));
      return response;
    }
  }

  Future<ResponseResetPassword> resetPassword (String newPassword) async {
    emit(state.copywhit(status: Forgetpasswordtatus.loading));
    String token = await persisteRepository.GetToken();
    ResponseResetPassword response = (await changeRepository.resetPassword(token , newPassword));
    print(response.message);
    if(response.estatus) {
      emit(state.copywhit(status: Forgetpasswordtatus.success));
      return response;
    } else {
      emit(state.copywhit(status: Forgetpasswordtatus.error));
      return response;
    }
  }
}
