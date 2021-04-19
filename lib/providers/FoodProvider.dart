import 'dart:convert';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:http/http.dart' as http;

class FoodProvider 
{
  final _url = 'https://a-bit-of-health-default-rtdb.firebaseio.com/';  

  Future<FoodOfferModel> getFoodOffers(String food) async {
     final url = '$_url/database/comida/$food.json';
     final answer =await http.get(url);
     Map<String , dynamic> data = json.decode(answer.body);
    FoodOfferModel foodOffer; 
  
      foodOffer = (FoodOfferModel.fromJson(data));
    print(foodOffer.toString());
    return foodOffer;
  }
 

}