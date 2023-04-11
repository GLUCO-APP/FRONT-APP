import 'package:gluko_repository/src/models/foodDetail.dart';
import 'package:gluko_service/gluko_service.dart';

class fooBarcodeRepository{

  Future<FoodDetail> foodBargode(String barcode) async {
    try{
      dynamic aux = await FoodBarcodeService().getFoodBarcode(barcode);
      FoodDetail food = FoodDetail(int.parse(aux['id'].toString()), aux['name'].toString(), double.parse(aux['carbs'].toString()), double.parse(aux['protein'].toString()), double.parse(aux['fats'].toString()), aux['image'].toString(), 0, "");
      return food;
    } on Exception{
      throw Exception("Fallo al crear el alimento");
    }

  }
}