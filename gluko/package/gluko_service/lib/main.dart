import 'dart:convert';

import 'package:gluko_service/gluko_service.dart';
import 'package:gluko_service/src/Data/foodBarcode_service.dart';
import 'package:gluko_service/src/Data/login_service.dart';
import 'package:gluko_service/src/Model/plateRequest.dart';

Future<void> main() async {
    var response =  await FoodBarcodeService().getFoodBarcode("7702085014363");
    print(response);
}

