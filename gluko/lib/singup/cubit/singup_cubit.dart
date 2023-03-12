import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit() : super(SingupInitial());
}
