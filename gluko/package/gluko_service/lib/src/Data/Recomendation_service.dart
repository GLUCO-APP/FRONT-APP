import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class RecomendationService {

  final http.Client request =  http.Client();

  Future<List> getRecomendations(String token) async{
    final uri = Uri.http(Routing().url_api,Routing().recomendation + token);
    http.Response response;
    List body;
    try{
      response = await request.get(uri);
      print (response);
      if(response.statusCode == 200){
        body = jsonDecode(response.body)as List;
        return body;
      }else{
        return [];
      }
    } on Exception{
      throw Exception();
    }

  }
}