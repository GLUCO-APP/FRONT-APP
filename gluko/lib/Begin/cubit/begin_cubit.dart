import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:meta/meta.dart';

part 'begin_state.dart';

class BeginCubit extends Cubit<BeginState> {
  BeginCubit(this.repository) : super(BeginState(actual: ActualStateDetail(0,0,0,"",0,0,0),recomend: []));

  ActualStatusRepository repository;

  Future<void> Iniciar() async{
    emit(state.confirmar() as BeginState);
  }

  Future<void> getEstadoActual() async {
    var estadoActual = await repository.getActualStatus();
    emit(state.copywhit(status: Beginstatus.success, actual: estadoActual));
  }
  ActualStateDetail getEstado(){
    return state.actual;
  }

  List<PlateRecomend> getRecomend(){
    return state.recomend;
  }

  Future<void> getRecomendacion() async{
    print("Inicia a Traer la recomendacion");
    var recomend = await RecomendationRepository().getPlateRecomend();
    print("Trae la recomendacion");
    emit(state.copywhit(recomendS: true, recomend: recomend));
  }

}
