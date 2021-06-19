import 'dart:collection';
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
  List<double> dailyCalories;
  List<double> dailyGlasses;
  List<double> dailyScore;

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
      this.lastSnack,
      this.dailyCalories,
      this.dailyGlasses,
      this.dailyScore});

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
      lastSnack: json['lastSnack'],
      dailyCalories: json['dailyCalories'].cast<double>(),
      dailyGlasses: json['dailyGlasses'].cast<double>(),
      dailyScore: json['dailyScore'].cast<double>());

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
        '"lastSnack"': jsonEncode(lastSnack),
        '"dailyCalories"': jsonEncode(dailyCalories),
        '"dailyGlasses"': jsonEncode(dailyGlasses),
        '"dailyScore"': jsonEncode(dailyScore)
      };

  @override
  String toString() =>
      '{ ${userID.toString()},${weight.toString()}, ${height.toString()}, ${email.toString()}, ${gender.toString()}, ${waterLimit.toString()},  ${name.toString()},${newWaterLimit.toString()},${waterLimitDate.toString()},${glasses.toString()},${lastConnection.toString()},${lastBreakfast.toString()},${lastLunch.toString()},${lastDinner.toString()},${lastSnack.toString()},${dailyCalories.toString()},${dailyGlasses.toString()},${dailyScore.toString()}';

  void setlastConnection(String date) {
    this.lastConnection = date;
  }

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

  void setTodaysCals(var daysoff) {
    print("La lista de calorías es: ${this.dailyCalories}");
    for (int i = 0; i < daysoff; i++) {
      dailyCalories.insert(i, 0);
      dailyCalories.removeLast();
    }
    print("Tras aumentar los días es: ${this.dailyCalories}");
  }

  void addToTodayCals(double calories) {
    this.dailyCalories.insert(0, calories);
    this.dailyCalories.removeAt(1);
  }

  double getFirstofDaily() {
    double res = this.dailyCalories.first;
    return res;
  }

  void setTodaysGlasses(var daysoff) {
    print("La lista de vasos es: ${this.dailyGlasses}");
    for (int i = 0; i < daysoff; i++) {
      dailyGlasses.insert(i, 0);
      dailyGlasses.removeLast();
    }
    print("Tras aumentar los días es: ${this.dailyCalories}");
  }

  void addToTodayGlasses(double glass) {
    this.dailyGlasses.insert(0, glass);
    this.dailyGlasses.removeAt(1);
  }

  double getFirstofGlasses() {
    double res = this.dailyGlasses.first;
    return res;
  }

  void setTodaysScore(var daysoff) {
    print("La lista de calorías es: ${this.dailyScore}");
    for (int i = 0; i < daysoff; i++) {
      dailyScore.insert(i, 0);
      dailyScore.removeLast();
    }
    print("Tras aumentar los días es: ${this.dailyCalories}");
  }

  void addToTodayScore(double score) {
    this.dailyScore.insert(0, score);
    this.dailyScore.removeAt(1);
  }

  double getFirstofScore() {
    double res = this.dailyScore.first;
    return res;
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
    dailyCalories = usr.dailyCalories;
    dailyGlasses = usr.dailyGlasses;
    dailyScore = usr.dailyScore;
  }

  void delete() {
    setUser(UserModel());
  }
}
