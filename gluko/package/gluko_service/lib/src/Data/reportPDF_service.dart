import 'package:http/http.dart' as http;

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

  Future<dynamic> getReportGrafsPDF(String token) async{
    final uri = Uri.http(Routing().url_api,Routing().reportPdf + token);
    print("------------------------------------------------------------------uri");
    print(uri);
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