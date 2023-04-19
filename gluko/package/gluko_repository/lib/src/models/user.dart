import 'insulin.dart';

class User {
  String nombre;
  String email;
  String password;
  String fechaNacimiento;
  String fechaDiagnostico;
  int edad;
  String genero;
  double peso;
  double estatura;
  String tipoDiabetes;
  String tipoTerapia;
  int hyper;
  int estable;
  int hipo;
  double sensitivity;
  int rate;
  String precis;
  String breakfast_start;
  String breakfast_end;
  String lunch_start;
  String lunch_end;
  String dinner_start;
  String dinner_end;
  Insulin insulinR;
  Insulin insulinL;
  int objective_carbs;
  int physicalctivity;
  String infoAdicional;


  User(
      this.nombre,
      this.email,
      this.password,
      this.fechaNacimiento,
      this.fechaDiagnostico,
      this.edad,
      this.genero,
      this.peso,
      this.estatura,
      this.tipoDiabetes,
      this.tipoTerapia,
      this.hyper,
      this.estable,
      this.hipo,
      this.sensitivity,
      this.rate,
      this.precis,
      this.breakfast_start,
      this.breakfast_end,
      this.lunch_start,
      this.lunch_end,
      this.dinner_start,
      this.dinner_end,
      this.insulinR,
      this.insulinL,
      this.objective_carbs,
      this.physicalctivity,
      this.infoAdicional,
      );

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'email': email,
    'password': password,
    'fechaNacimiento': fechaNacimiento,
    'fechaDiagnostico': fechaDiagnostico,
    'edad': edad,
    'genero': genero,
    'peso': peso,
    'estatura': estatura,
    'tipoDiabetes': tipoDiabetes,
    'tipoTerapia': tipoTerapia,
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
      {"id": insulinR.id},
      {"id": insulinL.id}
    ],
    'objective_carbs': objective_carbs,
    'physicalctivity': physicalctivity,
    'infoAdicional': infoAdicional,
  };

}
