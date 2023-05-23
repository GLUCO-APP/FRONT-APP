
import 'package:gluko_repository/gluko_repository.dart';
import 'package:gluko_repository/src/models/ReportRequest.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/PlateDetail.dart';

class RegisterReportRepository{

  Future<bool> RegisterReport (RequestReport report) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      var response = await ReportService().Report(token!, report.id_plato, report.glucosa, report.unidades_insulina);
      try{
        return response;
      }catch(ex){
        return response;
      }
    }on Exception{
      throw Exception();
    }

  }
}