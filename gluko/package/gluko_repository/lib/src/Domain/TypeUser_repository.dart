

import 'package:gluko_repository/src/models/ResponseLogin.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeUserRepository{

  Future<void> TyperUser() async {
    final prefs = await SharedPreferences.getInstance();
    var token =  prefs.getString('tokenJWT');
    var response = await typeUserService().gettypeUser(token!);
    if(response['success'] as bool){
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('TypeUser', response['tipo'].toString() );
    }
  }
}