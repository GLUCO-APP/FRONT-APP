import 'package:gluko_repository/src/models/ResponseChangePassword.dart';
import 'package:gluko_service/gluko_service.dart';
import '../../gluko_repository.dart';
import 'dart:convert';

class EditUserRepository{

  Future<ResponseEditUser> editUser (User user, String token) async {
    try{
      var userResponse = await EditUserService().EditUser(user, token);
      if(userResponse.statusCode == 201){
        var responseBody = jsonDecode(userResponse.body);
        var message = responseBody['message'];
        ResponseEditUser response = ResponseEditUser(true, message);
        return response;
      }else{
        ResponseEditUser response = ResponseEditUser(false, "No se pudo actualizar el usuario");
        return response;
      }
    } catch (e) {
      return ResponseEditUser(false, "Ocurrio un error");
    }

  }
}