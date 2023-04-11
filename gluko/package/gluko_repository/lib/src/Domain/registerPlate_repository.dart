
import 'package:gluko_service/gluko_service.dart';

import '../models/PlateDetail.dart';

class RegisterPlateRepository{

  Future<bool> RegisterPlate (PlateRegister plateRegister) async {
    try{
      List<PlateId> foods = plateRegister.foods.map((e) => PlateId(e.id)).toList();
      var response = await RegisterPlateService().RegisterPlate(plate(foods, plateRegister.sugarEstimate, plateRegister.Carbohydrates, plateRegister.Proteins, plateRegister.Fats, plateRegister.type, plateRegister.public_plate, plateRegister.latitude, plateRegister.longitude, plateRegister.address, plateRegister.Description, plateRegister.Title));
      return response;
    }on Exception{
      throw Exception();
    }

  }
}