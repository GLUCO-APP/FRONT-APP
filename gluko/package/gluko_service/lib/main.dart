
import 'package:gluko_service/gluko_service.dart';

Future<void> main() async {
   var response = await ReportPdfService().getReportGrafsPDF("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNhc3RhdG90cm9zQGdtYWlsLmNvbSIsImlhdCI6MTY4MzY4ODI2M30.9VuWilhF9yvzOCL7jtnfm2aO31ufH3vZi8VvSmyd68U");
   print(response);
}


