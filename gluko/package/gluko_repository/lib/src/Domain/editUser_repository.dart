import 'package:gluko_repository/src/models/ResponseChangePassword.dart';
import 'package:gluko_service/gluko_service.dart';
import '../../gluko_repository.dart';

class EditUserRepository{

  Future<ResponseEditUser> editUser (User user, String token) async {
    try{
      var userResponse = await EditUserService().EditUser(user, token);
      print("Response repository : ${userResponse}");
      if(userResponse != "contraseña incorrecta"){
        return ResponseEditUser(true, userResponse.toString());
      }
      return ResponseEditUser(false, userResponse.toString());
    } catch (e) {
      return ResponseEditUser(false, "Ocurrio un error");
    }

  }
}