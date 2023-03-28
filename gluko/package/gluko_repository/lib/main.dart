import 'package:gluko_repository/src/Domain/allfood_repository.dart';
import 'package:gluko_repository/src/models/foodDetail.dart';

Future<void> main() async {
  List<FoodDetail> comida = await allfoodRepository().getFood() ;
  print(comida[0].name);
}