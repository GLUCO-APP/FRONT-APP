class plate{
  plate(this.foods, this.sugarEstimate, this.Carbohydrates, this.Proteins, this.Fats, this.type, this.public_plate, this.latitude, this.longitude, this.address, this.Description, this.Title);
  final List<PlateId> foods;
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


  Map<String, dynamic> toJson() => {
    'foods': foods.map((food) => food.toJson()).toList(),
    'sugarEstimate': sugarEstimate,
    'Carbohydrates': Carbohydrates,
    'Proteins': Proteins,
    'Fats': Fats,
    'type': type,
    'public_plate': public_plate,
    'latitude': latitude,
    'longitude': longitude,
    'address': address,
    'Description': Description,
    'Title': Title,
  };
}
class PlateId{
  PlateId(this.id);
  final int id;
  Map<String, dynamic> toJson() => {
    'id': id,
  };
}