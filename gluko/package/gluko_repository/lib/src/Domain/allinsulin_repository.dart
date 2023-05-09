import 'package:gluko_repository/src/models/insulin.dart';
import 'package:gluko_service/gluko_service.dart';

class allinsulinRepository{

  Future<List<Insulin>> getInsulin() async {
    try{
      List<Insulin> all = [];
      List<dynamic> aux = await AllinsulinService().getAllInsulin();
      print(aux);
      for(int i = 0; i < aux.length; i++){
        all.add(
            Insulin(
                int.parse(aux[i]['id'].toString()),
                aux[i]['name'].toString(),
                aux[i]['type'].toString(),
                double.parse(aux[i]['iprecision'].toString()),
                int.parse(aux[i]['duration'].toString())
            )
        );
      }
      return all;
    } on Exception{
      throw Exception("Fallo al parcear los datos de los alimentos");
    }

  }
}