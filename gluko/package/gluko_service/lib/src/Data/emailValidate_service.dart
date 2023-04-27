import 'package:http/http.dart' as http;
import '../Routing.dart';
import 'dart:convert';
import 'dart:io';

class EmailValidateService {

  final http.Client request =  http.Client();

  Future<String> Validate( String email) async{
    final uri = Uri.http(Routing().url_api,Routing().validateEmail);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email});
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