
import 'package:gluko_service/src/Data/Recomendation_service.dart';
import 'package:gluko_service/src/Data/historialReports_service.dart';
import 'package:gluko_service/src/Data/typeuser_service.dart';

Future<void> main() async {
   var response = await typeUserService().gettypeUser("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNhc3RhdG90cm9zQGdtYWlsLmNvbSIsImlhdCI6MTY4MzY3NzY2OH0.UytUfZ5ORs_6WcufzgMcZbvbh_VJgFbKVmkeTwCq_Co");
   print(response);
}


