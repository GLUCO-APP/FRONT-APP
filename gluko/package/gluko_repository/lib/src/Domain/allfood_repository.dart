import 'package:gluko_repository/src/models/foodDetail.dart';
import 'package:gluko_service/gluko_service.dart';

class allfoodRepository{

  Future<List<FoodDetail>> getFood() async {
    try{
      List<FoodDetail> all = [];
      List<dynamic> aux = await AllfoodService().getAllFood();
      for(int i = 0; i < aux.length; i++){
        all.add(FoodDetail(int.parse(aux[i]['id'].toString()), aux[i]['name'].toString(), double.parse(aux[i]['carbs'].toString()), double.parse(aux[i]['protein'].toString()), double.parse(aux[i]['fats'].toString()), aux[i]['image'].toString(), int.parse(aux[i]['cuadrante'] != null ? aux[i]['cuadrante'].toString():"0"),aux[i]['tag'] != null ? aux[i]['tag'].toString(): "" ));
      }
      return all;
    } on Exception{
      throw Exception("Fallo al parcear los datos de los alimentos");
    }

  }
}