import 'dart:convert';
import 'package:gluko_service/src/Model/plateRequest.dart';
import 'package:http/http.dart' as http;

import '../Routing.dart';

class RegisterPlateService {

  final http.Client request =  http.Client();

  Future<dynamic> RegisterPlate( plate plateRegister ) async{
    final uri = Uri.http(Routing().url_api,Routing().registerPlate);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(plateRegister.toJson());
    print(body);
    try{
      final response = await http.post(uri, headers: headers, body: body).timeout(Duration(seconds: 100));

      if(response.statusCode == 201){
        var bodyRep = jsonDecode(response.body);
        return bodyRep;
      }else{
        return false;
      }
    } on Exception{
      print(Exception);
      throw Exception();
    }

  }
}