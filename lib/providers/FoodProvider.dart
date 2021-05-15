import 'dart:convert';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:http/http.dart' as http;

class FoodProvider {
  final _url = 'https://a-bit-of-health-default-rtdb.firebaseio.com/q/';

  //@param String the type of food the user ate
  //returns the offers of food stores in database
  Future<FoodOfferModel> getFoodOffers(String food) async {
    final url = '$_url/database/comida/$food.json';
    final answer = await http.get(url);
    Map<String, dynamic> data = json.decode(answer.body);
    FoodOfferModel foodOffer;

    foodOffer = (FoodOfferModel.fromJson(data));
    //print(foodOffer.toString());
    return foodOffer;
  }

  Future<void> uploadUserRegiter(userID, date, register) {
    final url = '$_url/database/calendar/$userID/$date/.json';

    final response =
        http.post(url, body: register.foodRegisterToJson(register));
  }
}
