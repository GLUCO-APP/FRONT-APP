import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;

part 'recomemende_plate_state.dart';

class RecomemendePlateCubit extends Cubit<RecomemendePlateState> {
  RecomemendePlateCubit(this.plate) : super(RecomemendePlateState(miposition: Position(
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
  ),));

  PlateRecomend plate;
  List<map.LatLng> polinateCordination = [];

  Future<void> getCurrentLocation(PointLatLng destino) async {
    var posicion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await rout(destino, PointLatLng(posicion.latitude, posicion.longitude));
    emit(state.copywhit(status: RecomemendePlatestatus.success, miposition: posicion));
  }

  Position getMyPosition(){
    return state.miposition;
  }


  Future<void> rout( PointLatLng destino,PointLatLng origen ) async{
      PolylinePoints polylinePoints = PolylinePoints();
      print("${origen.latitude} , ${origen.longitude}");
      print("${destino.latitude} , ${destino.longitude}");
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyDlE7-LR2nJKIePdwQm6KAGiP-t8qWnVp8",
          origen,
          destino,
          travelMode: TravelMode.walking,
      );
      if(result.points.isNotEmpty){
        result.points.forEach((PointLatLng point) => polinateCordination.add(map.LatLng(point.latitude, point.longitude)));
        print("Ün exito");
      }else{
        print("a mimir");
      }
  }
}
