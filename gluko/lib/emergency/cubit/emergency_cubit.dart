import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit(this._repository,this.rgreport,this.rgplate) : super(EmergencyState(infoUser:User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "")));
  Future<void> Iniciar() async{
    emit(state.confirmar() as EmergencyState);
  }

  EmergencyRepository _repository;
  RegisterPlateRepository rgplate;
  RegisterReportRepository rgreport;

  Future<EmergencyDetail> Emeregencia( String glucometria) async{
    emit(state.copywhit(status: Emergencystatus.loading));
    print(glucometria);
    EmergencyDetail response = await _repository.Emergency(glucometria);
    print(response.stadeEmergency);
    emit(state.copywhit(status: Emergencystatus.success));
    return response;
  }

  Future<void> getInfoUser() async{
    var user = await infoUserRepository().getInfoUser();
    print(user.sensitivity);
    print(user.rate);
    print(user.estable);
    emit(state.copywhit(status: Emergencystatus.success, infoUser: user));
  }
  Future<bool> RegisterPlate(PlateRegister plate, int glucosa, int insulina) async{
    emit(state.copywhit(status: Emergencystatus.loading));
    try{
      var response = await rgplate.RegisterPlate(plate);
      print("Respuesta ${response}");
      if(response.estatus){
        var reportResponse = await rgreport.RegisterReport(RequestReport(response.id, glucosa, insulina));
        if(reportResponse){
          emit(state.copywhit(status: Emergencystatus.success));
          return true;
        }else{
          emit(state.copywhit(status: Emergencystatus.success));
          return false;
        }
      }else{
        emit(state.copywhit(status: Emergencystatus.success));
        return false;
      }

    }catch(ex){
      emit(state.copywhit(status: Emergencystatus.success));
      return false;
    }
  }
}
