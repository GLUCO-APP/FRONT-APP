
class plateId {
  plateId(this.id);
  final int id;
}

class PlateRegister {
  PlateRegister(this.foods, this.sugarEstimate, this.Carbohydrates, this.Proteins, this.Fats, this.type, this.public_plate, this.latitude, this.longitude, this.address, this.Description, this.Title);
  final List<plateId> foods;
  final double sugarEstimate;
  final double Carbohydrates;
  final double Proteins;
  final double Fats;
  final String type;
  final int public_plate;
  final double latitude;
  final double longitude;
  final String address;
  final String Description;
  final String Title;
}