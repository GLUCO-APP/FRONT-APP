
import 'package:gluko_service/gluko_service.dart';
import '../models/ResponseSignUp.dart';
import '../models/user.dart';

class SignUpRepository{

  Future<ResponseSignUp> signUp (User usuario) async {
    try{
      var userResponse = await SignUpService().SignUp(
        usuario.nombre,
        usuario.email,
        usuario.password,
        usuario.fechaNacimiento,
        usuario.fechaDiagnostico,
        usuario.edad,
        usuario.genero,
        usuario.peso,
        usuario.estatura,
        usuario.tipoDiabetes,
        usuario.tipoTerapia,
        usuario.hyper,
        usuario.estable,
        usuario.hipo,
        usuario.sensitivity,
        usuario.rate,
        usuario.precis,
        usuario.breakfast_start,
        usuario.breakfast_end,
        usuario.lunch_start,
        usuario.lunch_end,
        usuario.dinner_start,
        usuario.dinner_end,
        usuario.insulinR.id,
        usuario.insulinL.id,
        usuario.objective_carbs,
        usuario.physicalctivity,
        usuario.infoAdicional,
        usuario.tipo_usuario
      );
      print("Response repository : ${userResponse}");
      if(userResponse == "Usuario creado"){
        return ResponseSignUp(true, "Usuario creado con exito");
      }
      return ResponseSignUp(false, userResponse);
    } catch (e) {
      return ResponseSignUp(false, "Ocurrio un error");
    }

  }
}