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
  String tipo_usuario;


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
      this.tipo_usuario
      );

  Map<String, dynamic> toJson() => {
    "usuario": {
      "nombre": nombre,
      "email": email,
      "fecha_nacimiento": fechaNacimiento,
      "fecha_diagnostico": fechaDiagnostico,
      "edad": edad,
      "genero": genero,
      "peso": peso,
      "estatura": estatura,
      "tipo_diabetes": tipoDiabetes,
      "tipo_terapia": tipoTerapia,
      "hyper": hyper,
      "estable": estable,
      "hipo": hipo,
      "sensitivity": sensitivity,
      "rate": rate,
      "basal": precis,
      "breakfast_start": breakfast_start,
      "breakfast_end": breakfast_end,
      "lunch_start": lunch_start,
      "lunch_end": lunch_end,
      "dinner_start": dinner_start,
      "dinner_end": dinner_end,
      "objective_carbs": objective_carbs,
      "physical_activity": physicalctivity,
      "info_adicional": infoAdicional,
      "tipo_usuario": tipo_usuario
    },
    "ins": [
      {
        "id": insulinR.id,
        "name": insulinR.name,
        "type": insulinR.type,
        "iprecision": insulinR.iprecision,
        "duration": insulinR.duration
      },
      {
        "id": insulinL.id,
        "name": insulinL.name,
        "type": insulinL.type,
        "iprecision": insulinL.iprecision,
        "duration": insulinL.duration
      }
    ]
  };

}
