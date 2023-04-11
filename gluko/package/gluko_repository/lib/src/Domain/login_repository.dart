

import 'package:gluko_repository/src/models/ResponseLogin.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository{

  Future<ResponseLogin> login (String email, String password) async {

    var response = await LoginService().Login(email, password);
    print("Response repository : ${response}");
    if(response != "contraseña incorrecta" && response != "usuario no encontrado"){
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenJWT', response);
      return ResponseLogin(true, "Login exitoso");
    }
    return ResponseLogin(false, response);
  }
}