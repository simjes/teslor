class Car {
  late int? id;
  late String? createdAt;
  late int? battery;
  late bool charging;
  late bool? parked;
  late int? interiorDegrees;
  late int? interiorDegreesTarget;
  late int? exteriorDegrees;
  late bool heatingWheel;
  late bool heatingSeatDriver;
  late bool heatingSeatShotgun;
  late bool heatingSeatDriverBack;
  late bool heatingSeatShotgunBack;
  late bool heatingSeatMiddleBack;
  late double? longitude;
  late double? latitude;
  late bool openFrunk;
  late bool openCar;
  late bool openTrunk;
  late bool openCharger;
  late String? name;
  late String? ownerId;

  Car(
      {this.id,
      this.createdAt,
      this.battery,
      this.charging = false,
      this.parked,
      this.interiorDegrees,
      this.interiorDegreesTarget,
      this.exteriorDegrees,
      this.heatingWheel = false,
      this.heatingSeatDriver = false,
      this.heatingSeatShotgun = false,
      this.heatingSeatDriverBack = false,
      this.heatingSeatShotgunBack = false,
      this.heatingSeatMiddleBack = false,
      this.longitude,
      this.latitude,
      this.openFrunk = false,
      this.openCar = false,
      this.openTrunk = false,
      this.openCharger = false,
      this.name,
      this.ownerId});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    battery = json['battery'];
    charging = json['charging'];
    parked = json['parked'];
    interiorDegrees = json['interior_degrees'];
    interiorDegreesTarget = json['interior_degrees_target'];
    exteriorDegrees = json['exterior_degrees'];
    heatingWheel = json['heating_wheel'];
    heatingSeatDriver = json['heating_seat_driver'];
    heatingSeatShotgun = json['heating_seat_shotgun'];
    heatingSeatDriverBack = json['heating_seat_driver_back'];
    heatingSeatShotgunBack = json['heating_seat_shotgun_back'];
    heatingSeatMiddleBack = json['heating_seat_middle_back'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    openFrunk = json['open_frunk'];
    openCar = json['open_car'];
    openTrunk = json['open_trunk'];
    openCharger = json['open_charger'];
    name = json['name'];
    ownerId = json['owner_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['battery'] = battery;
    data['charging'] = charging;
    data['parked'] = parked;
    data['interior_degrees'] = interiorDegrees;
    data['interior_degrees_target'] = interiorDegreesTarget;
    data['exterior_degrees'] = exteriorDegrees;
    data['heating_wheel'] = heatingWheel;
    data['heating_seat_driver'] = heatingSeatDriver;
    data['heating_seat_shotgun'] = heatingSeatShotgun;
    data['heating_seat_driver_back'] = heatingSeatDriverBack;
    data['heating_seat_shotgun_back'] = heatingSeatShotgunBack;
    data['heating_seat_middle_back'] = heatingSeatMiddleBack;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['open_frunk'] = openFrunk;
    data['open_car'] = openCar;
    data['open_trunk'] = openTrunk;
    data['open_charger'] = openCharger;
    data['name'] = name;
    data['owner_id'] = ownerId;
    return data;
  }
}
