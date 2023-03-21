import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  Future<void> Iniciar() async{
    emit(state.confirmar() as HomeState);
  }
}
