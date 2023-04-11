part of 'calculateinsulin_cubit.dart';
enum Calculateinsulinstatus{ loading,success,error}
class CalculateinsulinState {
  CalculateinsulinState({
    this.status = Calculateinsulinstatus.success,
    this.sugarEstimate = 0.0,
    this.Carbohydrates = 0.0,
    this.Proteins = 0.0,
    this.Fats = 0.0,
    this.type = '',
    this.public_plate = 0,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.address = '',
    this.Description = '',
    this.Title = '',
  });

  final Calculateinsulinstatus status;
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

  Calculateinsulinstatus confirmar(){
    return Calculateinsulinstatus.success;
  }

  CalculateinsulinState copyWith({
    Calculateinsulinstatus? status,
    double? sugarEstimate,
    double? Carbohydrates,
    double? Proteins,
    double? Fats,
    String? type,
    int? public_plate,
    double? latitude,
    double? longitude,
    String? address,
    String? Description,
    String? Title,
  }) {
    return CalculateinsulinState(
      status: status ?? this.status,
      sugarEstimate: sugarEstimate ?? this.sugarEstimate,
      Carbohydrates: Carbohydrates ?? this.Carbohydrates,
      Proteins: Proteins ?? this.Proteins,
      Fats: Fats ?? this.Fats,
      type: type ?? this.type,
      public_plate: public_plate ?? this.public_plate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      Description: Description ?? this.Description,
      Title: Title ?? this.Title,
    );
  }
}

