import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../Routing.dart';

class ReportPdfService {

  final http.Client request =  http.Client();

  Future<dynamic> getReportPDF(String token, String dia) async{
    final uri = Uri.http(Routing().url_api,Routing().reportPdf + token + "/$dia");
    http.Response response;
    List body;
    try{
      response = await request.get(uri);
      print(response.bodyBytes);
      if(response.statusCode == 200){
        body = response.bodyBytes as List;
        return body;
      }else{
        return false;
      }
    } catch(ex){
      print(ex);
    }

  }
}