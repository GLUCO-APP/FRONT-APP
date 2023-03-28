part of 'assembleplate_cubit.dart';
enum Assembleplatestatus{ loading,success,error}
class AssembleplateState {
//estados de la aplicacion
//Estados de carga, exito y error
  AssembleplateState( {
    this.foods = const <FoodDetail>[],
    this.status = Assembleplatestatus.loading,
});
  final Assembleplatestatus status;
  final List<FoodDetail> foods;
  AssembleplateState copywhit({
    Assembleplatestatus? status,
        List<FoodDetail>? foods,
  }){
    return AssembleplateState(status: status ?? this.status, foods: foods ?? this.foods);
  }
}

