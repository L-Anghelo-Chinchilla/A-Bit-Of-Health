import 'dart:collection';
import 'dart:convert';
import 'package:a_bit_of_health/models/FoodModel.dart';

import 'package:http/http.dart' as http;

class FoodProvider {
  final _url = 'https://a-bit-of-health-default-rtdb.firebaseio.com/q';

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

  Future<Map<String,FoodRegister>> getUserRegister(String userID, String date) async {
    final url = '$_url/database/calendar/$userID/$date.json';
    //String s ='{"aliments":[{"calories":0,"cant":1,"isSelected":true,"name":"Ninguno","portion":"0 gr"},{"calories":1069.7,"cant":1,"isSelected":false,"name":"Chizitos","portion":"190 gr"},{"calories":91.8,"cant":1,"isSelected":false,"name":"Nachos","portion":"107.1 gr"},{"calories":375,"cant":1,"isSelected":false,"name":"Palomitas de maíz","portion":"100 gr"},{"calories":160.8,"cant":1,"isSelected":false,"name":"Papas chips","portion":"30 gr"},{"calories":175,"cant":1,"isSelected":false,"name":"Maní salado","portion":"30 gr"},{"calories":154.5,"cant":1,"isSelected":false,"name":"Yuca salada","portion":"30 gr"},{"calories":411,"cant":1,"isSelected":false,"name":"Aros de cebolla","portion":"100 gr"},{"calories":133,"cant":1,"isSelected":false,"name":"Palitos salados","portion":"35 gr"},{"calories":201.6,"cant":1,"isSelected":false,"name":"Galletas saladas","portion":"40 gr"},{"calories":102.3,"cant":1,"isSelected":false,"name":"Arvejas saladas","portion":"30 gr"},{"calories":102.3,"cant":1,"isSelected":false,"name":"Habas saladas","portion":"30 gr"},{"calories":84.6,"cant":1,"isSelected":false,"name":"Chicharrones","portion":"30 gr"},{"calories":120,"cant":1,"isSelected":false,"name":"Platanitos salados","portion":"30 gr"}],"typeOfFood":"Desayuno"}';
   // var f = FoodOffer.fromJson(jsonDecode(s));
    //var f = FoodOffer(typeOfFood: 'Desayuno', aliments: [Food(calories: 10 , cant:  1 ,isSelected: true , name: 'sad' ,portion: '3'),Food(calories: 10 , cant:  1 ,isSelected: true , name: 'sad' ,portion: '3'),Food(calories: 10 , cant:  1 ,isSelected: true , name: 'sad' ,portion: '3')]);     
    //FoodRegister r = FoodRegister(calories: 500 , date: '12/5/1' ,score:  4 , time: '14:45', id: '' , food:f );
    final answer = await http.get(url);
    var sorted = SplayTreeMap<String , FoodRegister>();

    if(answer.bodyBytes.length > 4 ){
      Map<String,dynamic>json = jsonDecode(answer.body);
      json.forEach((key, value) 
      { 
        FoodRegister register = FoodRegister.fromJson(value); 
        register.id = key ;
        sorted[register.time] = register;
      });
    }
    
    return sorted;
  }


   Future<void> deleteRegisterByDate( userID , date , registerID) async {
     final url = '$_url/database/calendar/$userID/$date/$registerID.json';
     final response = await http.delete(url);
  }



}
