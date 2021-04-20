import 'dart:convert';


UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

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

  UserModel({this.userID,this.email,this.gender,this.height,this.name,this.waterLimit,this.weight,this.newWaterLimit,this.waterLimitDate,this.glasses});

  factory UserModel.fromJson(Map<String, dynamic> json) => 
  UserModel
  (
    weight :         json["weight"],
    height:          json["height"],
    email:           json["email"],
    gender:          json["gender"],
    waterLimit:      json["waterLimit"],
    name:            json["name"],
    newWaterLimit:   json['newWaterLimit'],
    glasses:   json['glasses'],
    waterLimitDate:  json['waterLimitDate']
  );


  Map<String, dynamic> toJson() => 
  {
    
    '"weight"'          :jsonEncode(weight),  
    '"height"'          :jsonEncode(height), 
    '"email"'           :jsonEncode(email), 
    '"gender"'          :jsonEncode(gender), 
    '"name"'            :jsonEncode(name), 
    '"waterLimit"'      :jsonEncode(waterLimit), 
    '"newWaterLimit"'   :jsonEncode(newWaterLimit), 
    '"waterLimitDate"'  :jsonEncode(waterLimitDate),
    '"glasses"'  :jsonEncode(glasses),
     
  };

  @override
  String toString() => 
  '{ ${userID.toString()},${weight.toString()}, ${height.toString()}, ${email.toString()}, ${gender.toString()}, ${waterLimit.toString()},  ${name.toString()},${newWaterLimit.toString()},${waterLimitDate.toString()},${glasses.toString()}}';


  void setID(String id) { this.userID = id ;} 
}
