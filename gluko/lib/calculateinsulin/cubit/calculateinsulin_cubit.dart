import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'calculateinsulin_state.dart';

class CalculateinsulinCubit extends Cubit<CalculateinsulinState> {
  CalculateinsulinCubit(this.rgplate) : super(CalculateinsulinState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as CalculateinsulinState);
  }

  RegisterPlateRepository rgplate;

  Future<bool> RegisterPlate(PlateRegister plate) async{
    emit(state.copyWith(status:Calculateinsulinstatus.loading));
    try{
      var response = await rgplate.RegisterPlate(plate);
      print("Respuesta ${response}");
      if(response){
        emit(state.copyWith(status: Calculateinsulinstatus.success));
        return true;
      }else{
        emit(state.copyWith(status: Calculateinsulinstatus.success));
        return false;
      }

    }catch(ex){
      emit(state.copyWith(status: Calculateinsulinstatus.success));
      return true;
    }
  }
}
