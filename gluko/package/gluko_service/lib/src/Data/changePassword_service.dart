import 'package:http/http.dart' as http;
import '../Routing.dart';
import 'dart:convert';
import 'dart:io';

class ChangePasswordService {

  final http.Client request =  http.Client();

  Future<String> change( String token, String oldPassword, String newPassword) async{
    final uri = Uri.http(Routing().url_api,Routing().changePassword+ '/$token' + '/$oldPassword' + '/$newPassword',);
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