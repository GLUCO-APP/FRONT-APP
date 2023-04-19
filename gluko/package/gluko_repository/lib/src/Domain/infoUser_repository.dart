import 'package:gluko_repository/src/models/foodDetail.dart';
import 'package:gluko_repository/src/models/insulin.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gluko_repository.dart';

class infoUserRepository{

  Future<User> getInfoUser() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      var aux = await InfoUserService().getUser(token!);
      print(aux);
      try{
        User user = User(aux['nombre'].toString(),aux['email'].toString() , "", aux['fecha_nacimiento'].toString(),aux['fecha_diagnostico'].toString(),int.parse(aux['edad'].toString()),aux['genero'].toString() , double.parse(aux['peso'].toString()), double.parse(aux['estatura'].toString()) , aux['tipo_diabetes'].toString(),aux['tipo_terapia'].toString(),int.parse(aux['hyper'].toString()) , int.parse(aux['estable'].toString()), int.parse(aux['hipo'].toString()), double.parse(aux['sensitivity'].toString()),int.parse(aux['rate'].toString()), aux['precis'].toString(), aux['breakfast_start'].toString(), aux['breakfast_end'].toString(), aux['lunch_start'].toString(), aux['lunch_end'].toString(),aux['dinner_start'].toString() , aux['dinner_end'].toString(), Insulin(0,"", "", 0, 0), Insulin(0,"", "", 0, 0), int.parse(aux['objective_carbs'].toString()), double.parse(aux['physical_activity'].toString()).toInt(), aux['info_adicional'].toString());
        return user;
      }catch(ex){
        print(ex);
        return User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "");
      }

    } on Exception{
      throw Exception("Fallo al parcear los datos del usuario");
    }

  }
}