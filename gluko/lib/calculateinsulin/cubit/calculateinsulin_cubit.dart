import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'calculateinsulin_state.dart';

class CalculateinsulinCubit extends Cubit<CalculateinsulinState> {
  CalculateinsulinCubit(this.rgplate, this.rgreport) : super(CalculateinsulinState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as CalculateinsulinState);
  }

  RegisterPlateRepository rgplate;
  RegisterReportRepository rgreport;

  Future<bool> RegisterPlate(PlateRegister plate, int glucosa, int insulina) async{
    emit(state.copyWith(status:Calculateinsulinstatus.loading));
    try{
      var response = await rgplate.RegisterPlate(plate);
      print("Respuesta ${response}");
      if(response.estatus){
        var reportResponse = await rgreport.RegisterReport(RequestReport(response.id, glucosa, insulina));
        if(reportResponse){
          return true;
        }else{
          emit(state.copyWith(status: Calculateinsulinstatus.success));
          return false;
        }
      }else{
        emit(state.copyWith(status: Calculateinsulinstatus.success));
        return false;
      }

    }catch(ex){
      emit(state.copyWith(status: Calculateinsulinstatus.success));
      return false;
    }
  }
}
