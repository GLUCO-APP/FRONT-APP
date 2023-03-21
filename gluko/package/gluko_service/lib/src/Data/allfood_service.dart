import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class AllfoodService {

  final http.Client request =  http.Client();

  Future<List> getAllFood() async{
      final uri = Uri.http(Routing().url_api,Routing().allFood);
      http.Response response;
      List body;
      try{
        response = await request.get(uri);

        if(response.statusCode == 200){
            body = jsonDecode(response.body)['data'] as List;
            return body;
        }else{
          throw HttpException(response.body);
        }
      } on Exception{
          throw Exception();
      }

  }
}