import 'dart:collection';
import 'dart:convert';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class FoodProvider {
  static final _url = 'https://a-bit-of-health-default-rtdb.firebaseio.com/q';

  //@param String the type of food the user ate
  //returns the offers of food stores in database
  Future<FoodOfferModel> getFoodOffers(String food) async {
    final url = '$_url/database/comida/$food.json';
    final uri = Uri.parse(url);
    final answer = await http.get(uri);
    Map<String, dynamic> data = json.decode(answer.body);
    FoodOfferModel foodOffer;
    foodOffer = (FoodOfferModel.fromJson(data));
    return foodOffer;
  }

  Future<Map<String, FoodRegister>> getUserRegister(
      String userID, String date) async {
    final url = '$_url/database/calendar/$userID/$date.json';
    print(url);
    final uri = Uri.parse(url);
    final answer = await http.get(uri);
    var sorted = SplayTreeMap<String, FoodRegister>();

    if (answer.bodyBytes.length > 4) {
      Map<String, dynamic> json = jsonDecode(answer.body);
      json.forEach((key, value) {
        FoodRegister register = FoodRegister.fromJson(value);
        register.id = key;
        sorted[register.time] = register;
      });
    }

    return sorted;
  }

  Future<void> deleteRegisterByDate(userID, date, registerID) async {
    final url = '$_url/database/calendar/$userID/$date/$registerID.json';
    print(url);
    final Uri uri = Uri.parse('url');
    final response = await Dio().delete(url);
  }

  Future<void> uploadUserRegiter(userID, date, register) {
    final url = '$_url/database/calendar/$userID/$date/.json';
    final Uri uri = Uri.parse(url);
    final response =
        http.post(uri, body: register.foodRegisterToJson(register));
  }
  //YYYY-MM-DD
  static  Future<Map<String, FoodRegister>> getUserRegisterRange(
      String userID, String startDate, String endDate) async {
    final url = '$_url/database/calendar/$userID.json';
    print(url);
    final uri = Uri.parse(url);
    final answer = await http.get(uri);
    var sorted = SplayTreeMap<String, FoodRegister>();
   
    if (answer.bodyBytes.length > 4) {
      Map<String, dynamic> jsonYear = jsonDecode(answer.body);
      jsonYear.forEach((key, value) {
      if(int.parse(key) >= int.parse(startDate.substring(0,4))   && 
         int.parse(key) <= int.parse(endDate.substring(0,4) )) 
        value.forEach((key, value) {
        
        if(int.parse(key) >= int.parse(startDate.substring(5,7))   && 
            int.parse(key) <= int.parse(endDate.substring(5,7) )) 
          value.forEach((key, value) {
          if(int.parse(key) >= int.parse(startDate.substring(8,10))   && 
            int.parse(key) <= int.parse(endDate.substring( 8,10 ) )) 

          value.forEach((key, value) {
        
            FoodRegister register = FoodRegister.fromJson( value);
              register.id = key;
              sorted['${register.date}${register.time}'] = register;
              
          });
          });
        });
      });
    }

    return sorted;
  }
}
