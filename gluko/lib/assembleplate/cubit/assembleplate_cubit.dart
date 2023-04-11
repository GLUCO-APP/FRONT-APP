
import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';

part 'assembleplate_state.dart';

class AssembleplateCubit extends Cubit<AssembleplateState> {
  AssembleplateCubit(this._repository, this._repositoryBarcode) : super(AssembleplateState());

  final allfoodRepository _repository;
  final fooBarcodeRepository _repositoryBarcode;


  Future<void> getFoods() async{
    try{
      List<FoodDetail> foods = await _repository.getFood();
      emit(state.copywhit(status: Assembleplatestatus.success, foods: foods) as AssembleplateState);
    }catch(ex){
      emit(state.copywhit(status: Assembleplatestatus.error));
    }
  }

  Future<FoodDetail> getFoodBarcode(String barcode) async{
    emit(state.copywhit(status: Assembleplatestatus.loading));
    try{
      FoodDetail food = await _repositoryBarcode.foodBargode(barcode);
      print("Respuesta ${food}");
      emit(state.copywhit(status: Assembleplatestatus.success));
      return food;
    }catch(ex){
      emit(state.copywhit(status: Assembleplatestatus.success));
      return FoodDetail(0, "", 0, 0, 0, "", 0, "");
    }
  }


}
