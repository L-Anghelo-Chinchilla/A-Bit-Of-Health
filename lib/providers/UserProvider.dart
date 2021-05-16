import 'dart:convert';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class UserProvider {
  static final _url =
      'https://a-bit-of-health-default-rtdb.firebaseio.com/q/database/users/';

  // @param (string user ID in database)
  // Returns the UserData by an HTTP request

  static Future<UserModel> getUserData(String userID) async {
    final url = '$_url$userID.json';
    print(url);
    final uri = Uri.parse(url);
    final answer = await http.get(uri);
    Map<String, dynamic> data = json.decode(answer.body);
    UserModel userData = (UserModel.fromJson(data));
      
    userData.setID(userID);
    print(userData.toJson());
    return userData;
  }

  //@param  user ID from database , the new limit to set
  //retunrs true if  success
  Future<bool> setUserWaterLimit(String userID, int newLimit) async {
    final url = '$_url$userID/.json';
    var user = await getUserData(userID);
    user.newWaterLimit = newLimit;
    user.waterLimitDate = DateTime.now().add(Duration(days:1)).toString().split(" ").first;
    final uri = Uri.parse(url);
    http.put(uri, body: user.toJson().toString());
    return true;
  }

  //@param user Id from data base , the glasses consumed
  //returns true if success
  Future<bool> setUserWaterGlasses(String userID, int glass) async {
    final url = '$_url$userID/.json';
    var user = await getUserData(userID);
    user.glasses = glass;
    final uri = Uri.parse(url);
    http.put(uri, body: user.toJson().toString());
    return true;
  }

  Future<void> checkUserGlasses(String userID) async {
    UserModel user = await getUserData(userID);
    if (user.waterLimit != user.newWaterLimit &&
        user.waterLimitDate == DateTime.now().toString().split(" ").first) {
      user.waterLimit = user.newWaterLimit;
      final url = '$_url$userID.json';
      Uri uri = Uri.parse(url);
      http.put(uri, body: user.toJson().toString());
    }
  }

  Future<void> updateTodayGlasses(String userID) async {
    UserModel user = await getUserData(userID);

    if (user.lastConnection != DateTime.now().toString().split(" ").first) {
      user.glasses = 0;
      user.lastConnection = DateTime.now().toString().split(" ").first;
      final url = '$_url$userID.json';
      Uri uri = Uri.parse(url);
      http.put(uri, body: user.toJson().toString());

      
    }
  }

 /*Future <Tuple2<bool ,String >> login(email, password){


    return 
  }*/ 
}
