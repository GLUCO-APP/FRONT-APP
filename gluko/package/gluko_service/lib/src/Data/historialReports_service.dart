import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class AllReportService {

  final http.Client request =  http.Client();

  Future<List> getAllReport(String token) async{
    final uri = Uri.http(Routing().url_api,Routing().reportsAll +token+ "/7");
    http.Response response;
    List body;
    try{
      response = await request.get(uri);

      if(response.statusCode == 200){
        body = jsonDecode(response.body) as List;
        return body;
      }else{
        throw HttpException(response.body);
      }
    } on Exception{
      throw Exception();
    }

  }
}