import 'dart:convert';

import 'package:flutter/cupertino.dart';

FoodOfferModel foodOfferModelFromJson(String str) =>
    FoodOfferModel.fromJson(json.decode(str));

String foodOfferModelToJson(FoodOfferModel data) => json.encode(data.toJson());

class FoodOfferModel with ChangeNotifier {
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

  void valueChanged(String name, String foodName, bool value) {
    foodOffers.forEach((element) {
      if (element.typeOfFood == name) element.setValueChanged(foodName, value);
    });
    notifyListeners();


  }
    setFoodOffers(List<FoodOffer> newValue){foodOffers = newValue;}

  FoodOfferModel getItself() => this;

  FoodOffer getAt(int i) => foodOffers[i];



  List<FoodOffer> getSelectedOnes(){
     List<FoodOffer> list = [];
      foodOffers.forEach((element) { list.add(element.getSelectedOnes());  });
    return list;

  }
}

class FoodOffer with ChangeNotifier {
  String typeOfFood;
  List<Food> aliments;

  FoodOffer({this.typeOfFood, this.aliments});

  FoodOffer foodOfferFromJson(String str) =>
      FoodOffer.fromJson(json.decode(str));

  String foodOfferToJson(FoodOfferModel data) => json.encode(data.toJson());

  factory FoodOffer.fromJson(Map<String, dynamic> json) {
    Iterable l = json['aliments'];
    List<Food> aliments =
        List<Food>.from(l.map((model) => Food.fromJson(model)));
    return FoodOffer(typeOfFood: json['typeOfFood'], aliments: aliments);
  }

  Map<String, dynamic> toJson() =>
      {"typeOfFood": typeOfFood, "Aliments": jsonEncode(aliments)};

  @override
  String toString() => '{ ${this.typeOfFood} , ${jsonEncode(this.aliments)} }';

  void setValueChanged(String name, bool value) {
    aliments.forEach((element) {
      if (name == element) print('$element set to $value');
    });
    notifyListeners();
  }

  String getTypeOfFood() => typeOfFood;
  Food getFoodAt(int i) => aliments[i];


  FoodOffer getSelectedOnes(){
   return FoodOffer(typeOfFood:this.typeOfFood, aliments: aliments.where((element) => element.isSelected && element.name != 'Ninguno').toList());

  }
}

class Food extends ChangeNotifier{
  String name;
  double calories;
  bool isSelected;
  String portion;
  int cant;

  Food({this.calories, this.cant, this.isSelected, this.name, this.portion});

  FoodOffer foodFromJson(String str) => FoodOffer.fromJson(json.decode(str));

  String foodToJson(FoodOfferModel data) => json.encode(data.toJson());

  factory Food.fromJson(Map<String, dynamic> json) => Food(
      name: json['name'],
      calories: json['calories'],
      isSelected: json['isSelected'],
      portion: json['portion'],
      cant: json['cant']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "calories": calories,
        "isSelected": isSelected,
        "portion": portion,
        "cant": cant
      };

  String getName    () => name ;
  double getCalories() => calories;
  bool getIsSelected() => isSelected;
  String getPortion () => portion;
  int getCant       () => cant; 
  setIsSelected() {isSelected = !isSelected; notifyListeners();  }
  setCant(int newValue) {cant = newValue; }
}
