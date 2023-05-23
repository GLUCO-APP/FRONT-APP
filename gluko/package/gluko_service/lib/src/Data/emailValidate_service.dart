import 'package:http/http.dart' as http;
import '../Routing.dart';
import 'dart:convert';
import 'dart:io';

class EmailValidateService {

  final http.Client request =  http.Client();

  Future<String> Validate( String email) async{
    final uri = Uri.http(Routing().url_api,Routing().validateEmail + '/$email',);
    final headers = {'Content-Type': 'application/json'};
    String bodyRep;
    try{
      final response = await http.get(uri, headers: headers).timeout(Duration(seconds: 10));
      if(response.statusCode == 200){
        bodyRep = jsonDecode(response.body)['codigo'].toString();
        return bodyRep;
      }else{
        throw HttpException(response.body);
      }
    } on Exception{
      throw Exception();
    }

  }
}