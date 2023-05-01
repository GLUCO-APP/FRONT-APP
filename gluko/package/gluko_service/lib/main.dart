
import 'package:gluko_service/src/Data/Recomendation_service.dart';
import 'package:gluko_service/src/Data/historialReports_service.dart';

Future<void> main() async {
   var response = await AllReportService().getAllReport("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1YW5AZXhhbXBsZS5jb20iLCJpYXQiOjE2ODE2MTkxMjl9.2sN6SSX6sC9OuANUhK3hbWYkwRj8BtUjV9s_kHttpzI");
   print(response);
}


