import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReportPDFRepository{

  Future<File> getPDF(int dia) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      List bytes = await ReportPdfService().getReportPDF(token!, dia.toString() ) as List;
      final dir = await getApplicationDocumentsDirectory();
      print(dir);
      final file = File('${dir.path}/reporte${TimeOfDay.hoursPerDay}.pdf');
      List<int> data = bytes.map((e) => e as int).toList();
      await file.writeAsBytes(data);
      return file;
    } catch(ex){
      throw Exception("Fallo al traer los datos del PDF");
    }

  }
}