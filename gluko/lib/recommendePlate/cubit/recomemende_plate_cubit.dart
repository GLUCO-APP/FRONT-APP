import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'recomemende_plate_state.dart';

class RecomemendePlateCubit extends Cubit<RecomemendePlateState> {
  RecomemendePlateCubit() : super(RecomemendePlateState(miposition: Position(
    latitude: 37.4219999,
    longitude: -122.0840575,
    timestamp: DateTime.now(),
    accuracy: 10.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    floor: null,
    isMocked: false,
  )));

  Future<Position> getCurrentLocation() async {
    var posicion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    emit(state.copywhit(status: RecomemendePlatestatus.success, miposition: posicion));
    return posicion;
  }

  Position getMyPosition(){
    return state.miposition;
  }
}
