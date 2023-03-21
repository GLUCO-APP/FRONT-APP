import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as ProfileState);
  }
}
