import 'package:gluko_repository/gluko_repository.dart';

class PlateRecomend {
  PlateRecomend(this.foods, this.sugarEstimate, this.Carbohydrates, this.Proteins, this.Fats, this.type, this.latitude, this.longitude, this.address, this.Description, this.id);
  final List<FoodDetail> foods;
  final double sugarEstimate;
  final double Carbohydrates;
  final double Proteins;
  final double Fats;
  final String type;
  final double latitude;
  final double longitude;
  final String address;
  final String Description;
  final int id;
}