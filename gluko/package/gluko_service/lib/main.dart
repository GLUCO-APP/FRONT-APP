import 'dart:convert';

import 'package:gluko_service/gluko_service.dart';
import 'package:gluko_service/src/Data/emergency_service.dart';
import 'package:gluko_service/src/Data/foodBarcode_service.dart';
import 'package:gluko_service/src/Data/login_service.dart';
import 'package:gluko_service/src/Data/report_service.dart';
import 'package:gluko_service/src/Model/plateRequest.dart';

Future<void> main() async {
   var response = await InfoUserService().getUser("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1YW5AZXhhbXBsZS5jb20iLCJpYXQiOjE2ODE2MTkxMjl9.2sN6SSX6sC9OuANUhK3hbWYkwRj8BtUjV9s_kHttpzI");
   print(response);
}

