import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class LoginService {

  final http.Client request =  http.Client();

  Future<String> Login( String email, String password) async{
    final uri = Uri.http(Routing().url_api,Routing().login);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'password': password});
    String bodyRep;
    try{
      final response = await http.post(uri, headers: headers, body: body).timeout(Duration(seconds: 10));
      if(response.statusCode == 200){
        bodyRep = jsonDecode(response.body)['status'] as String;
        return bodyRep;
      }else{
        throw HttpException(response.body);
      }
    } on Exception{
      throw Exception();
    }

  }
}