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
}