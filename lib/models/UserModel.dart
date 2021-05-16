import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String userID;
  double weight;
  double height;
  String email;
  String gender;
  int waterLimit;
  int newWaterLimit;
  int glasses;
  String waterLimitDate;
  String name;
  String lastConnection;

  UserModel(
      {this.userID,
      this.email,
      this.gender,
      this.height,
      this.name,
      this.waterLimit,
      this.weight,
      this.newWaterLimit,
      this.waterLimitDate,
      this.glasses,
      this.lastConnection});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      weight: json["weight"],
      height: json["height"],
      email: json["email"],
      gender: json["gender"],
      waterLimit: json["waterLimit"],
      name: json["name"],
      newWaterLimit: json['newWaterLimit'],
      glasses: json['glasses'],
      lastConnection: json['lastConnection'],
      waterLimitDate: json['waterLimitDate']);

  Map<String, dynamic> toJson() => {
        '"weight"': jsonEncode(weight),
        '"height"': jsonEncode(height),
        '"email"': jsonEncode(email),
        '"gender"': jsonEncode(gender),
        '"name"': jsonEncode(name),
        '"waterLimit"': jsonEncode(waterLimit),
        '"newWaterLimit"': jsonEncode(newWaterLimit),
        '"waterLimitDate"': jsonEncode(waterLimitDate),
        '"lastConnection"': jsonEncode(lastConnection),
        '"glasses"': jsonEncode(glasses),
      };

  @override
  String toString() =>
      '{ ${userID.toString()},${weight.toString()}, ${height.toString()}, ${email.toString()}, ${gender.toString()}, ${waterLimit.toString()},  ${name.toString()},${newWaterLimit.toString()},${waterLimitDate.toString()},${glasses.toString()},${lastConnection.toString()}}';

  void setID(String id) {
    userID = id;
  }

  void setUser(UserModel usr) {
    userID = usr.userID;
    weight = usr.weight;
    height = usr.height;
    email = usr.email;
    gender = usr.gender;
    waterLimit = usr.waterLimit;
    newWaterLimit = usr.newWaterLimit;
    glasses = usr.glasses;
    waterLimitDate = usr.waterLimitDate;
    name = usr.name;
    lastConnection = usr.lastConnection;
  }

  void delete(){
    setUser(UserModel());
  }
}
