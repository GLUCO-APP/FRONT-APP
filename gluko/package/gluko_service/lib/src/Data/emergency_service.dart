import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class EmergencyService {

  final http.Client request =  http.Client();

  Future<dynamic> Emergency( String token, String glucemia) async{
    final uri = Uri.http(Routing().url_api,Routing().emergency + "/$token" + "/$glucemia",);
    http.Response response;
    try{
      response = await request.post(uri);
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        return null;
      }
    } on Exception{
      print(Exception().toString());
      throw Exception();
    }

  }
}