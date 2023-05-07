import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class InfoUserService {

  final http.Client request =  http.Client();

  Future<dynamic> getUser(String token) async{
    final uri = Uri.http(Routing().url_api,Routing().infoUser+"/$token");
    http.Response response;
    var body;
    try{
      response = await request.get(uri);

      if(response.statusCode == 200){
        body = jsonDecode(response.body);
        print("imprime el body");
        print(body);
        return body;
      }else{
        throw HttpException(response.body);
      }
    } on Exception{
      throw Exception();
    }

  }
}