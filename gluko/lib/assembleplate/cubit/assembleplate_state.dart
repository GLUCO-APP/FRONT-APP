part of 'assembleplate_cubit.dart';
enum Assembleplatestatus{ loading,success,error}
class AssembleplateState {
//estados de la aplicacion
//Estados de carga, exito y error
  AssembleplateState({
    this.status = Assembleplatestatus.success
});
  final Assembleplatestatus status;
  Assembleplatestatus confirmar(){
      return Assembleplatestatus.success;
  }
}

