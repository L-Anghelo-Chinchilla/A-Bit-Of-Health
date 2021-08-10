import 'dart:convert';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 2), () => "2");
  }

  //@param  user ID from database , the new limit to set
  //retunrs true if  success
  Future<bool> setUserWaterLimit(String userID, int newLimit) async {
    final url = '$_url$userID/.json';
    Uri uri = Uri.parse(url);
    var user = await getUserData(userID);
    user.newWaterLimit = newLimit;
    user.waterLimitDate =
        DateTime.now().add(Duration(days: 1)).toString().split(" ").first;
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
    await http.put(uri, body: user.toJson().toString());
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
      //user.lastConnection = DateTime.now().toString().split(" ").first;
      final url = '$_url$userID.json';
      Uri uri = Uri.parse(url);
      await http.put(uri, body: user.toJson().toString());
    }
  }

  DateFormat formatter = DateFormat('d');
  DateFormat formatter2 = DateFormat('yyyy-MM-dd');

  Future<void> updateLastConnection(String userID) async {
    sleep1();
    UserModel user = await getUserData(userID);
    String today = formatter2.format(DateTime.now());
    user.setlastConnection(today);
    final url = '$_url$userID.json';
    Uri uri = Uri.parse(url);
    await http.put(uri, body: user.toJson().toString());
  }

  Future<void> updateDailyCalories(String userID) async {
    UserModel user = await getUserData(userID);
    var lastCon = DateTime.parse(user.lastConnection);
    var daysoff = DateTime.now().difference(lastCon).inDays;
    String today = formatter.format(DateTime.now());
    String thelastCon = formatter.format(lastCon);

    if (int.parse(today) != int.parse(thelastCon)) {
      await user.setTodaysCals(daysoff);
      final url = '$_url$userID.json';
      Uri uri = Uri.parse(url);
      await http.put(uri, body: user.toJson().toString());
    }
  }

  Future<void> addToTodaysCalories(String userID, double calories) async {
    UserModel user = await getUserData(userID);

    user.addToTodayCals(calories);

    final url = '$_url/$userID.json';
    Uri uri = Uri.parse(url);
    await http.put(uri, body: user.toJson().toString());
  }

  Future<double> getAllTodayCalories(String userID) async {
    UserModel user = await getUserData(userID);

    double res = user.getFirstofDaily();

    return res;
  }

  Future<void> updateDailyGlasses(String userID) async {
    UserModel user = await getUserData(userID);
    var lastCon = DateTime.parse(user.lastConnection);
    var daysoff = DateTime.now().difference(lastCon).inDays;
    String today = formatter.format(DateTime.now());

    String thelastCon = formatter.format(lastCon);

    if (int.parse(today) != int.parse(thelastCon)) {
      await user.setTodaysGlasses(daysoff);
      final url = '$_url$userID.json';
      Uri uri = Uri.parse(url);
      await http.put(uri, body: user.toJson().toString());
    }
  }

  Future<void> addToTodaysGlasses(String userID, double glass) async {
    UserModel user = await getUserData(userID);

    user.addToTodayGlasses(glass);

    final url = '$_url/$userID.json';
    Uri uri = Uri.parse(url);
    await http.put(uri, body: user.toJson().toString());
  }

  Future<double> getAllTodayGlasses(String userID) async {
    UserModel user = await getUserData(userID);

    double res = user.getFirstofGlasses();

    return res;
  }

  Future<List<dynamic>> obtainDailyGlasses(String userID) async {
    UserModel user = await getUserData(userID);
    return user.dailyGlasses;
  }

  Future<void> updateDailyScore(String userID) async {
    UserModel user = await getUserData(userID);
    var lastCon = DateTime.parse(user.lastConnection);
    var daysoff = DateTime.now().difference(lastCon).inDays;

    String today = formatter.format(DateTime.now());
    String thelastCon = formatter.format(lastCon);

    if (int.parse(today) != int.parse(thelastCon)) {
      await user.setTodaysScore(daysoff);
      final url = '$_url$userID.json';
      Uri uri = Uri.parse(url);
      await http.put(uri, body: user.toJson().toString());
    }
  }

  Future<void> addToTodaysScore(String userID, double score) async {
    UserModel user = await getUserData(userID);

    user.addToTodayScore(score);

    final url = '$_url/$userID.json';
    Uri uri = Uri.parse(url);
    await http.put(uri, body: user.toJson().toString());
  }

  Future<double> getAllTodayScore(String userID) async {
    UserModel user = await getUserData(userID);

    double res = user.getFirstofScore();

    return res;
  }

  Future<List<dynamic>> getGforStats(String userID) async {
    UserModel user = await getUserData(userID);
    return user.dailyGlasses;
  }

  Future<List<dynamic>> getCforStats(String userID) async {
    UserModel user = await getUserData(userID);
    return user.dailyCalories;
  }

  Future<List<dynamic>> getSforStats(String userID) async {
    UserModel user = await getUserData(userID);
    return user.dailyScore;
  }

  Future<void> updateTodayCalories(
      String userID, String typeOdFood, String calories) async {
    UserModel user = await getUserData(userID);

    switch (typeOdFood) {
      case "Desayuno":
        user.setLastBreakfast(calories);
        break;
      case "Almuerzo":
        user.setLastLunch(calories);
        break;
      case "Cena":
        user.setLastDinner(calories);
        break;
      case "Snack":
        user.setLastSnack(calories);
        break;

      default:
        break;
    }
    final url = '$_url/$userID.json';
    Uri uri = Uri.parse(url);
    await http.put(uri, body: user.toJson().toString());
  }

  Future<String> getLastFood(String userID, String typeofFood) async {
    UserModel user = await getUserData(userID);
    String res;
    switch (typeofFood) {
      case "Desayuno":
        res = user.getLastBreakfast();
        break;
      case "Almuerzo":
        res = user.getLastLunch();
        break;
      case "Cena":
        res = user.getLastDinner();
        break;
      case "Snack":
        res = user.getLastSnack();
        break;

      default:
        break;
    }
    return res;
  }
}
