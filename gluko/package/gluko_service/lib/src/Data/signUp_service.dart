import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class SignUpService {

  final http.Client request =  http.Client();

  Future<String> SignUp(
      String nombre,
      String email,
      String password,
      String fechaNacimiento,
      String fechaDiagnostico,
      int edad,
      String genero,
      double peso,
      double estatura,
      String tipoDiabetes,
      String tipoTerapia,
      int hyper,
      int estable,
      int hipo,
      double sensitivity,
      int rate,
      String precis,
      String breakfast_start,
      String breakfast_end,
      String lunch_start,
      String lunch_end,
      String dinner_start,
      String dinner_end,
      int insulinR,
      int insulinL,
      int objective_carbs,
      int physicalctivity,
      String infoAdicional,
      ) async {
    final uri = Uri.http(Routing().url_api, Routing().createUser);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'nombre': nombre,
      'email': email,
      'password': password,
      'fecha_nacimiento': fechaNacimiento,
      'fecha_diagnostico': fechaDiagnostico,
      'edad': edad,
      'genero': genero,
      'peso': peso,
      'estatura': estatura,
      'tipo_diabetes': tipoDiabetes,
      'tipo_terapia': tipoTerapia,
      'hyper': hyper,
      'estable': estable,
      'hipo': hipo,
      'sensitivity': sensitivity,
      'rate': rate,
      'precis': precis,
      'breakfast_start': breakfast_start,
      'breakfast_end': breakfast_end,
      'lunch_start': lunch_start,
      'lunch_end': lunch_end,
      'dinner_start': dinner_start,
      'dinner_end': dinner_end,
      'insulin': [
        {"id": insulinR},
        {"id": insulinL}
      ],
      'objective_carbs': objective_carbs,
      'physical_activity': physicalctivity,
      'info_adicional': infoAdicional,
    });
    String bodyRep;
    try {
      print(body);
      final response = await http
          .post(uri, headers: headers, body: body)
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 201) {
        bodyRep = jsonDecode(response.body)['status'] as String;
        return bodyRep;
      } else {
        throw HttpException(response.body);
      }
    } on Exception {
      throw Exception();
    }
  }

}