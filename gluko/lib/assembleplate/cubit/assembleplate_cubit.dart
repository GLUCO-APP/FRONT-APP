import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'assembleplate_state.dart';

class AssembleplateCubit extends Cubit<AssembleplateState> {
  AssembleplateCubit() : super(AssembleplateState());

  Future<void> prueba() async{
    emit(state.confirmar() as AssembleplateState);
  }
}
