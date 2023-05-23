import 'package:flutter/services.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthApi{
  static final _auth = LocalAuthentication();
  static Future<bool> authenticate() async{
    final isAvalible = await hasBiometric();
    print(isAvalible);
    if(!isAvalible){
      return false;
    }
    try{
      var result  = await _auth.authenticate(localizedReason: "Escanea tu huella para continuar",
          authMessages: [
            AndroidAuthMessages(
              signInTitle: 'Escanea tue huella',
              cancelButton: 'No gracias',
            )]);
      return result;
    } on PlatformException catch (ex){
      return false;
    }

  }
  static Future<bool> hasBiometric() async{
    try{
      return await _auth.canCheckBiometrics;
    }on PlatformException catch (ex){
      return false;
    }
  }

}