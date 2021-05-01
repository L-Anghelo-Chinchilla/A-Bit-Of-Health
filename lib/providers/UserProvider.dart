import 'dart:convert';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final _url =
      'https://a-bit-of-health-default-rtdb.firebaseio.com/database/users/';

  // @param (string user ID in database)
  // Returns the UserData by an HTTP request

  Future<UserModel> getUserData(String userID) async {
    final url = '$_url$userID.json';
    final answer = await http.get(url);
    Map<String, dynamic> data = json.decode(answer.body);
    UserModel userData = (UserModel.fromJson(data));
      print(userData.toJson());
    userData.setID(userID);
    return userData;
  }

  //@param  user ID from database , the new limit to set
  //retunrs true if  success
  Future<bool> setUserWaterLimit(String userID, int newLimit) async {
    final url = '$_url$userID/.json';
    var user = await getUserData(userID);
    user.newWaterLimit = newLimit;
    user.waterLimitDate = DateTime.now().add(Duration(days:1)).toString().split(" ").first;
    http.put(url, body: user.toJson().toString());
    return true;
  }

  //@param user Id from data base , the glasses consumed
  //returns true if success
  Future<bool> setUserWaterGlasses(String userID, int glass) async {
    final url = '$_url$userID/.json';
    var user = await getUserData(userID);
    user.glasses = glass;
    http.put(url, body: user.toJson().toString());
    return true;
  }

  Future<void> checkUserGlasses(String userID) async {
    UserModel user = await getUserData(userID);
    if (user.waterLimit != user.newWaterLimit &&
        user.waterLimitDate == DateTime.now().toString().split(" ").first) {
      user.waterLimit = user.newWaterLimit;
      final url = '$_url$userID.json';
      http.put(url, body: user.toJson().toString());
    }
  }

  Future<void> updateTodayGlasses(String userID) async {
    UserModel user = await getUserData(userID);

    if (user.lastConnection != DateTime.now().toString().split(" ").first) {
      user.glasses = 0;
      user.lastConnection = DateTime.now().toString().split(" ").first;
      final url = '$_url$userID.json';
      http.put(url, body: user.toJson().toString());

      
    }
  }
}
