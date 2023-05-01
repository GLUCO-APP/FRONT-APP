import 'package:gluko_service/gluko_service.dart';

import '../models/ResponseValidate.dart';

class EmailValidateRepository {
  Future<ResponseValidate> validateC(String email) async {

    var response = await EmailValidateService().Validate(email);
    print("Response repository : ${response}");
    if(response != null){
      return ResponseValidate(true, response);
    }
    return ResponseValidate(false, response);
  }
}