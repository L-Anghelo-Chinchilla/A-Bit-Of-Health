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
  String name;

  UserModel({this.email,this.gender,this.height,this.name,this.waterLimit,this.weight});

  factory UserModel.fromJson(Map<String, dynamic> json) => 
  UserModel
  (
    weight :    json["weight"],
    height:     json["height"],
    email:      json["email"],
    gender:     json["gender"],
    waterLimit: json["waterLimit"],
    name:       json["name"]
  );
  Map<String, dynamic> toJson() => 
  {
    
    '"weight"'      :jsonEncode(weight),  
    '"height"'      :jsonEncode(height), 
    '"email"'       :jsonEncode(email), 
    '"gender"'      :jsonEncode(gender), 
    '"waterLimit"'  :jsonEncode(waterLimit), 
    '"name"'        :jsonEncode(name) 
  };

  @override
  String toString() => 
  '{ ${userID.toString()},${weight.toString()}, ${height.toString()}, ${email.toString()}, ${gender.toString()}, ${waterLimit.toString()},  ${name.toString()}}';


  void setID(String id) { this.userID = id ;} 
}
