import 'package:gluko_repository/gluko_repository.dart';

Future<void> main() async {
  var report = await allReportRepository().getAllReport();
  print(report);
}