import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gluko_repository/src/models/insulin.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository, this.pRepository) : super(ProfileState(infoUser:User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "", ""),));
  infoUserRepository repository;
  PercisteRepository pRepository;

  Future<void> getInfoUser() async{
    var user = await repository.getInfoUser();
    emit(state.copywhit(status: profilestatus.success, infoUser: user));
    print("Respuesta ${user.nombre}");
  }

  User getUser(){
    return state.infoUser;
  }

}
