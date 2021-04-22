import 'dart:convert';

import 'package:flutter/cupertino.dart';

FoodOfferModel foodOfferModelFromJson(String str) =>
    FoodOfferModel.fromJson(json.decode(str));

String foodOfferModelToJson(FoodOfferModel data) => json.encode(data.toJson());

class FoodOfferModel with ChangeNotifier{
  List<FoodOffer> foodOffers;

  FoodOfferModel({this.foodOffers});

  factory FoodOfferModel.fromJson(Map<String, dynamic> json) {
    var aux = json['foodOffer'] as List;
    List<FoodOffer> auxList =
        aux.map((foodOffer) => FoodOffer.fromJson(foodOffer)).toList();
    return FoodOfferModel(foodOffers: auxList);
  }

  Map<String, dynamic> toJson() => {"foodOffers": jsonEncode(foodOffers)};

  @override
  String toString() => '{ ${foodOffers.toString()} }';

  void valueChanged(String name ,String foodName , bool value){

    foodOffers.forEach((element) {if(element.typeOfFood == name) element.setValueChanged(foodName ,  value); });
    notifyListeners();
  }

    FoodOfferModel getItself() => this;
}

class FoodOffer with ChangeNotifier{
  String typeOfFood;
  List<String> aliments;



  FoodOffer({this.typeOfFood, this.aliments, /*this.values*/});



    FoodOffer foodOfferFromJson(String str) =>
    FoodOffer.fromJson(json.decode(str));


String foodOfferToJson(FoodOfferModel data) => json.encode(data.toJson());


  factory FoodOffer.fromJson(Map<String, dynamic> json) { 
    Iterable l = json['aliments'];
List<String> aliments = List<String>.from(l.map((model)=> model ));
    return FoodOffer(
      typeOfFood: json['typeOfFood'], aliments:aliments);
  }


  Map<String, dynamic> toJson() =>
      {"typeOfFood": typeOfFood, "Aliments": jsonEncode(aliments)};



  @override
  String toString() => '{ ${this.typeOfFood} , ${jsonEncode(this.aliments)} }';


  void setValueChanged(String name , bool value){
    aliments.forEach((element) { if(name == element) print('$element set to $value');});
  notifyListeners();
  }
}
