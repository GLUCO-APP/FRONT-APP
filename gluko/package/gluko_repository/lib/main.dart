import 'package:gluko_repository/src/Domain/allfood_repository.dart';
import 'package:gluko_repository/src/Domain/foodBarcode_repository.dart';
import 'package:gluko_repository/src/models/foodDetail.dart';

Future<void> main() async {
  FoodDetail comida = await fooBarcodeRepository().foodBargode("7702085014363");
  print(comida.name);
}