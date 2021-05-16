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
  String lastBreakfast;
  String lastLunch;
  String lastDinner;
  String lastSnack;

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
      this.lastConnection,
      this.lastBreakfast,
      this.lastLunch,
      this.lastDinner,
      this.lastSnack});

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
      waterLimitDate: json['waterLimitDate'],
      lastBreakfast: json['lastBreakfast'],
      lastLunch: json['lastLunch'],
      lastDinner: json['lastDinner'],
      lastSnack: json['lastSnack']);


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
        '"lastBreakfast"': jsonEncode(lastBreakfast),
        '"lastLunch"': jsonEncode(lastLunch),
        '"lastDinner"': jsonEncode(lastDinner),
        '"lastSnack"': jsonEncode(lastSnack)
      };

  @override
  String toString() =>
      '{ ${userID.toString()},${weight.toString()}, ${height.toString()}, ${email.toString()}, ${gender.toString()}, ${waterLimit.toString()},  ${name.toString()},${newWaterLimit.toString()},${waterLimitDate.toString()},${glasses.toString()},${lastConnection.toString()}},${lastBreakfast.toString()}},${lastLunch.toString()}},${lastDinner.toString()}},${lastSnack.toString()}}';

  void setID(String id) {
    this.userID = id;
  }

  void setLastBreakfast(String lB) {
    this.lastBreakfast = lB;
  }

  void setLastLunch(String lL) {
    this.lastLunch = lL;
  }

  void setLastDinner(String lD) {
    this.lastDinner = lD;
  }

  void setLastSnack(String lS) {
    this.lastSnack = lS;
  }

  String getLastBreakfast() {
    return this.lastBreakfast;
  }

  String getLastLunch() {
    return this.lastLunch;
  }

  String getLastDinner() {
    return this.lastDinner;
  }

  String getLastSnack() {
    return this.lastSnack;
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
    lastBreakfast = usr.lastBreakfast;
    lastLunch = usr.lastLunch;
    lastDinner = usr.lastDinner;
    lastSnack = usr.lastSnack;
  }

  void delete(){
    setUser(UserModel());}
}
