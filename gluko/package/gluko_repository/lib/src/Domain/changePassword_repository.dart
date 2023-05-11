
import 'package:gluko_service/gluko_service.dart';
import '../models/ResponseSignUp.dart';
import '../models/user.dart';

class ChangePasswordRepository{

  Future<String> changePassword (String token, String oldPassword, String newPassword) async {
    try{
      var userResponse = await ChangePasswordService().change(token, oldPassword, newPassword);
      print("Response repository : ${userResponse}");
      if(userResponse != "contraseña incorrecta"){
        return ResponseSignUp(true, "Usuario creado con exito");
      }
      return ResponseSignUp(false, userResponse);
    } catch (e) {
      return ResponseSignUp(false, "Ocurrio un error");
    }

  }
}