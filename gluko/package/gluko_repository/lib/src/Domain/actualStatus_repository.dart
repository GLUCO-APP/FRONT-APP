
import 'package:gluko_repository/src/models/ActualStateDetail.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gluko_repository.dart';

class ActualStatusRepository{

  Future<ActualStateDetail> getActualStatus() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  await prefs.getString('tokenJWT');
      var response = await ActualStateService().getActualState(token!);
      var user = await infoUserRepository().getInfoUser();
      ActualStateDetail estado = ActualStateDetail(
          response['objective_carbs'] != null? double.parse(response['objective_carbs'].toString()):120,
          response['sum_carbs'] != null?double.parse(response['sum_carbs'].toString()):0,
          response['glucosa'] != null?double.parse(response['glucosa'].toString()):0,
          response['fecha'] != null?response['fecha'].toString():DateTime.now().toString(),
          response['unidades_insulina'] != null? double.parse(response['unidades_insulina'].toString()):0,
          user.hyper.toDouble(),
          response['unidades_restantes'] != null? double.parse(response['unidades_restantes'].toString()):0
      );
      return estado;
    } on Exception{
      throw Exception("Fallo al traer el estado");
    }

  }
}