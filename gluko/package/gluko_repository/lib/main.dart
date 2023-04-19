import 'package:gluko_repository/gluko_repository.dart';
import 'package:gluko_repository/src/Domain/allfood_repository.dart';
import 'package:gluko_repository/src/Domain/emergency_repository.dart';
import 'package:gluko_repository/src/Domain/foodBarcode_repository.dart';
import 'package:gluko_repository/src/Domain/signUp_repository.dart';
import 'package:gluko_repository/src/models/ResponseSignUp.dart';
import 'package:gluko_repository/src/models/foodDetail.dart';
import 'package:gluko_repository/src/models/insulin.dart';
import 'package:gluko_repository/src/models/user.dart';

Future<void> main() async {
  FoodDetail comida = await fooBarcodeRepository().foodBargode("7702085014363");
  print(comida.name);
  
  ResponseSignUp responseSignUp = await SignUpRepository().signUp(User(
      "Juan Perez",
      "juan.perez@example.com",
      "password123",
      "1990-05-20",
      "2010-10-01",
      31,
      "masculino",
      70.5,
      1.75,
      "Tipo 1",
      "Insulina",
      180,
      120,
      70,
      14,
      40,
      "22:00",
      "08:00",
      "10:00",
      "13:00",
      "15:00",
      "20:00",
      "22:00",
      Insulin(1, "Humulin R Cristalina", "Bolo", 1, 8),
      Insulin(7, "Delemir Levemir", "Basal", 0.5, 18),
      300,
      3,
      "Ninguna"));
  print(responseSignUp.message);
}