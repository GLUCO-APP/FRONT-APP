import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/responePDF.dart';


class ReportPDFRepository{

  Future<ResponsePDF> getPDF(int dia) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      List bytes = await ReportPdfService().getReportPDF(token!, dia.toString() ) as List;
      final dir = await getApplicationDocumentsDirectory();
      print(dir);
      final file = File('${dir.path}/reporte${TimeOfDay.hoursPerDay}.pdf');
      List<int> data = bytes.map((e) => e as int).toList();
      await file.writeAsBytes(data);
      return ResponsePDF(true, file);
    } catch(ex){
      return ResponsePDF(false, File(""));
    }

  }

  Future<ResponsePDF> getPDFGraft() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      List bytes = await ReportPdfService().getReportGrafsPDF(token!) as List;
      final dir = await getApplicationDocumentsDirectory();
      print(dir);
      final file = File('${dir.path}/reporte${TimeOfDay.hoursPerDay}.pdf');
      List<int> data = bytes.map((e) => e as int).toList();
      await file.writeAsBytes(data);
      return ResponsePDF(true, file);
    } catch(ex){
      return ResponsePDF(false, File(""));
    }

  }
}