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
        User user = User(
            aux['usuario']['nombre'].toString(),
            aux['usuario']['email'].toString() ,
            "",
            aux['usuario']['fecha_nacimiento'].toString(),
            aux['usuario']['fecha_diagnostico'].toString(),
            int.parse(aux['usuario']['edad'].toString()),
            aux['usuario']['genero'].toString() ,
            double.parse(aux['usuario']['peso'].toString()),
            double.parse(aux['usuario']['estatura'].toString()) ,
            aux['usuario']['tipo_diabetes'].toString(),
            aux['usuario']['tipo_terapia'].toString(),
            int.parse(aux['usuario']['hyper'].toString()) ,
            int.parse(aux['usuario']['estable'].toString()),
            int.parse(aux['usuario']['hipo'].toString()),
            double.parse(aux['usuario']['sensitivity'].toString()),
            int.parse(aux['usuario']['rate'].toString()),
            aux['usuario']['basal'].toString(),
            aux['usuario']['breakfast_start'].toString(),
            aux['usuario']['breakfast_end'].toString(),
            aux['usuario']['lunch_start'].toString(),
            aux['usuario']['lunch_end'].toString(),
            aux['usuario']['dinner_start'].toString() ,
            aux['usuario']['dinner_end'].toString(),
            Insulin(
                int.parse(aux['ins'][0]["id"].toString()),
                aux['ins'][0]["name"].toString(),
                aux['ins'][0]["type"].toString(),
                double.parse(aux['ins'][0]["iprecision"].toString()),
                int.parse(aux['ins'][0]["duration"].toString())
            ),
            Insulin(
                int.parse(aux['ins'][1]["id"].toString()),
                aux['ins'][1]["name"].toString(),
                aux['ins'][1]["type"].toString(),
                double.parse(aux['ins'][1]["iprecision"].toString()),
                int.parse(aux['ins'][1]["duration"].toString())
            ),
            int.parse(aux['usuario']['objective_carbs'].toString()),
            double.parse(aux['usuario']['physical_activity'].toString()).toInt(),
            aux['usuario']['info_adicional'].toString(),
            aux['usuario']['tipo_usuario'].toString()
        );
        return user;
      }catch(ex){
        print(ex);
        return User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "", "");
      }

    } on Exception{
      throw Exception("Fallo al parcear los datos del usuario");
    }

  }
}