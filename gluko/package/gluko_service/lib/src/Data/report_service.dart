import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Routing.dart';

class ReportService {

  final http.Client request =  http.Client();

  Future<bool> Report( String token, int idPlate, int glucosa, int insulina ) async {
    final uri = Uri.http(Routing().url_api,Routing().report);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'id_plato': idPlate,
      'token_usuario': token,
      'glucosa': glucosa,
      'unidades_insulina': insulina,
    }
    );
    print("LLegaAqui");
    print(body);
    try{
      final response = await http.post(uri, headers: headers,  body: body).timeout(Duration(seconds: 100));
      print(response.body);
      if(response.statusCode == 201){
        return true;
      }else{
        return false  ;
      }
    } catch(ex){
      return false;
    }
  }
}