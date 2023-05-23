
import 'package:gluko_repository/gluko_repository.dart';
import 'package:gluko_service/gluko_service.dart';

import '../models/PlateDetail.dart';

class RegisterPlateRepository{

  Future<ResponsePlate> RegisterPlate (PlateRegister plateRegister) async {
    try{
      List<PlateId> foods = plateRegister.foods.map((e) => PlateId(e.id)).toList();
      var response = await RegisterPlateService().RegisterPlate(plate(foods, plateRegister.sugarEstimate, plateRegister.Carbohydrates, plateRegister.Proteins, plateRegister.Fats, plateRegister.type, plateRegister.public_plate, plateRegister.latitude, plateRegister.longitude, plateRegister.address, plateRegister.Description, plateRegister.Title));
      try{
        if(response['id'] != ""){
          return ResponsePlate(true, int.parse(response['id'].toString()));
        }else{
          return ResponsePlate(false, -1);
        }
      }catch(ex){
        return ResponsePlate(false, -1);
      }
    }on Exception{
      throw Exception();
    }

  }
}