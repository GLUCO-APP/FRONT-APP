import 'dart:convert';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:http/http.dart' as http;

import '../Routing.dart';

class EditUserService {

  final http.Client request =  http.Client();

  Future<dynamic> EditUser( User usuario, String token) async{
    final uri = Uri.http(Routing().url_api,Routing().editUser + '$token');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(usuario.toJson());
    print(body);
    try{
      final response = await http.put(uri, headers: headers, body: body).timeout(Duration(seconds: 100));
      print(response.statusCode);
      return response;
    } on Exception{
      print(Exception);
      throw Exception();
    }

  }
}