import 'package:shared_preferences/shared_preferences.dart';

class PercisteRepository{

  Future<bool> isAutenticate() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      if(token!.isNotEmpty){
        return true;
      }else{
        return false;
      }
    } catch (e){
      return false;
    }
  }

  Future<bool> logout() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("tokenJWT", "");
      return true;
    } catch (e){
      return false;
    }
  }
  Future<bool> UserType() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var tipe =  prefs.getString('TypeUser');
      if(tipe == "Tutor"){
        //si es tutor se devuelve verdadero y se valida la biometria
        return true;
      }else{
        //es un paciente a si que no se valida la biometria
        return false;
      }
    } catch (e){
      return false;
    }
  }
  Future<String> GetToken() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
       return token!;
    } catch (e){
      return "";
    }
  }
}