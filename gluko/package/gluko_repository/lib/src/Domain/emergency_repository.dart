import 'package:gluko_repository/src/models/EmergencyDetail.dart';
import 'package:gluko_repository/src/models/foodDetail.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyRepository{

  Future<EmergencyDetail> Emergency(String glucometria) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      print(token!);
      List<FoodDetail> all = [];
      var messege;
      var correccion;
      List<dynamic> foods = [];
      var response = await EmergencyService().Emergency(token, glucometria);
      if( response != null){
        var state = response['state'];
        if(state == 0){
          foods = response['food'] as List;
          messege = response['message'];
        }
        if(state == 1){
          messege = response['message'];
        }
        if(state == 2){
          messege = response['message'];
          correccion = response['correcion'];
          if(double.parse(correccion.toString()).toInt() == 0){
            state = 1;
          }
        }
        for(int i = 0; i < foods.length; i++){
          all.add(FoodDetail(int.parse(foods[i]['id'].toString()), foods[i]['name'].toString(), double.parse(foods[i]['carbs'].toString()), double.parse(foods[i]['protein'].toString()), double.parse(foods[i]['fats'].toString()), foods[i]['image'].toString(), int.parse(foods[i]['cuadrante'] != null ? foods[i]['cuadrante'].toString():"0"),foods[i]['tag'] != null ? foods[i]['tag'].toString(): "" ));
        }
        EmergencyDetail emergencyresponse = EmergencyDetail(correccion != null? double.parse(correccion.toString()).toInt() : 0,int.parse(state.toString()),all,messege.toString());
        return emergencyresponse;
      }else{
        return EmergencyDetail(0, 3, [], "No se encontro usuario");
      }

    } on Exception{
      throw Exception("Fallo al parcear los datos de los alimentos");
    }
  }
}