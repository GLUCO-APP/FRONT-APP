
import 'package:bloc/bloc.dart';
import 'package:gluko_repository/gluko_repository.dart';

part 'assembleplate_state.dart';

class AssembleplateCubit extends Cubit<AssembleplateState> {
  AssembleplateCubit(this._repository) : super(AssembleplateState());

  final allfoodRepository _repository;

  Future<void> getFoods() async{
    try{
      final foods = await _repository.getFood();
      print(foods);
      emit(state.copywhit(status: Assembleplatestatus.success, foods: foods) as AssembleplateState);
    }catch(ex){
      emit(state.copywhit(status: Assembleplatestatus.error));
    }

  }
}
