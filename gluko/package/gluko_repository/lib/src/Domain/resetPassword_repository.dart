import 'package:gluko_repository/src/models/ResponseResetPassword.dart';
import 'package:gluko_service/gluko_service.dart';

class ResetPasswordRepository{

  Future<ResponseResetPassword> resetPassword (String token, String newPassword) async {
    try{
      var userResponse = await ResetPasswordService().reset(newPassword, token);
      print("Response repository : ${userResponse}");
      if(userResponse != "contraseña incorrecta"){
        return ResponseResetPassword(true, userResponse);
      }
      return ResponseResetPassword(false, userResponse);
    } catch (e) {
      return ResponseResetPassword(false, "Ocurrio un error");
    }

  }
}