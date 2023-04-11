import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Routing.dart';

class FoodBarcodeService {

  final http.Client request =  http.Client();

  Future<dynamic> getFoodBarcode(String barcode) async{
    final uri = Uri.http(Routing().url_api,Routing().foodBarcode + "/$barcode");
    http.Response response;
    var body;
    try{
      response = await request.post(uri);

      if(response.statusCode == 201){
        body = jsonDecode(response.body);
        return body;
      }else{
        throw HttpException(response.body);
      }
    } on Exception{
      throw Exception();
    }

  }
}