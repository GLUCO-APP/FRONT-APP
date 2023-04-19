import 'package:gluko_repository/gluko_repository.dart';

class EmergencyDetail{
  EmergencyDetail(this.insulina, this.stadeEmergency, this.food, this.messege);
  final String messege;
  final int insulina;
  final int stadeEmergency;
  final List<FoodDetail> food;
}