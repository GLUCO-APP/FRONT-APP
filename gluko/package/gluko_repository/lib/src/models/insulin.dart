class Insulin{
  int id;
  String name;
  String type;
  double precision;
  int duration;

  Insulin(
      this.id,
      this.name,
      this.type,
      this.precision,
      this.duration
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'precision': precision,
    'duration': duration,
  };
}