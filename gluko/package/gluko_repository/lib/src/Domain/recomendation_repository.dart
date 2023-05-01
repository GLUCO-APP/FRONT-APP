import 'package:gluko_repository/gluko_repository.dart';
import 'package:gluko_repository/src/models/foodDetail.dart';
import 'package:gluko_service/gluko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecomendationRepository{

  Future<List<PlateRecomend>> getPlateRecomend() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      var token =  prefs.getString('tokenJWT');
      print(token!);
      List<PlateRecomend> platesrecomd = [];
      List<dynamic> plates = await RecomendationService().getRecomendations("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1YW5AZXhhbXBsZS5jb20iLCJpYXQiOjE2ODE2MTkxMjl9.2sN6SSX6sC9OuANUhK3hbWYkwRj8BtUjV9s_kHttpzI");
      for(int j = 0; j < plates.length; j++){
        List<FoodDetail> all = [];
        List<dynamic> aux = plates[j]['foods'] as List;
        for(int i = 0; i < aux.length; i++){
          all.add(FoodDetail(int.parse(aux[i]['id'].toString()), aux[i]['name'].toString(), double.parse(aux[i]['carbs'].toString()), double.parse(aux[i]['protein'].toString()), double.parse(aux[i]['fats'].toString()), aux[i]['image'].toString(), int.parse(aux[i]['cuadrante'] != null ? aux[i]['cuadrante'].toString():"0"),aux[i]['tag'] != null ? aux[i]['tag'].toString(): "" ));
        }
        var plR = PlateRecomend(
            all,
            double.parse(plates[j]['plateJSON']['sugarEstimate'].toString()),
            double.parse(plates[j]['plateJSON']['Carbohydrates'].toString()),
            double.parse(plates[j]['plateJSON']['Proteins'].toString()),
            double.parse(plates[j]['plateJSON']['Fats'].toString()),
            plates[j]['plateJSON']['type'].toString(),
            double.parse(plates[j]['plateJSON']['latitude'].toString()),
            double.parse(plates[j]['plateJSON']['longitude'].toString()),
            plates[j]['plateJSON']['address'].toString(),
            plates[j]['plateJSON']['descript'].toString(),
            int.parse(plates[j]['plateJSON']['id'].toString()));
        platesrecomd.add(plR);
      }
      return platesrecomd;
    } on Exception{
      throw Exception("Fallo al parcear los platos recomendados");
    }

  }
}