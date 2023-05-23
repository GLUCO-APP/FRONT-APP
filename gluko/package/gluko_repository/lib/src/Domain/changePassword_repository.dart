import 'package:gluko_repository/src/models/ResponseChangePassword.dart';
import 'package:gluko_service/gluko_service.dart';

class ChangePasswordRepository{

  Future<ResponseChangePassword> changePassword (String token, String oldPassword, String newPassword) async {
    try{
      var userResponse = await ChangePasswordService().change(token, oldPassword, newPassword);
      print("Response repository : ${userResponse}");
      if(userResponse != "contraseña incorrecta"){
        return ResponseChangePassword(true, userResponse);
      }
      return ResponseChangePassword(false, userResponse);
    } catch (e) {
      return ResponseChangePassword(false, "Ocurrio un error");
    }

  }
}