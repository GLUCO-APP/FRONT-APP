import 'package:gluko_repository/src/models/foodDetail.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ReportDetail.dart';

class allReportRepository{

  Future<List<RequestDetail>> getAllReport() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      List<RequestDetail> all = [];
      List<dynamic> aux = await AllReportService().getAllReport(token!);
      for(int i = 0; i < aux.length; i++){
        all.add(RequestDetail(aux[i]['fecha'].toString(), aux[i]['glucosa'].toString(), aux[i]['unidades_insulina'].toString(), aux[i]['type'].toString(), aux[i]['Carbohydrates'].toString()));
      }
      return all;
    } on Exception{
      throw Exception("Fallo al parcear los reportes");
    }

  }
}