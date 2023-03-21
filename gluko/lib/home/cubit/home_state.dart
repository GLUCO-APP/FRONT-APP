part of 'home_cubit.dart';
enum Hometatus{ loading,success,error}
class HomeState {
  HomeState({
    this.status = Hometatus.success
  });

  final Hometatus status;

  Hometatus confirmar(){
    return Hometatus.success;
  }
}

