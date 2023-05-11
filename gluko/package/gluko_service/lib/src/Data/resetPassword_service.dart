import 'package:http/http.dart' as http;
import '../Routing.dart';
import 'dart:convert';
import 'dart:io';

class ResetPasswordService {

  final http.Client request =  http.Client();

  Future<String> reset(String newPassword, String token) async{
    final uri = Uri.http(Routing().url_api,Routing().resetPassword+ '/$token' + '/$newPassword',);
    final headers = {'Content-Type': 'application/json'};
    String bodyRep;
    try{
      final response = await http.put(uri, headers: headers).timeout(Duration(seconds: 10));
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