import 'dart:convert';

FoodOfferModel foodOfferModelFromJson(String str) =>
    FoodOfferModel.fromJson(json.decode(str));

String foodOfferModelToJson(FoodOfferModel data) => json.encode(data.toJson());

class FoodOfferModel {
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
}

class FoodOffer {
  String typeOfFood;
  List<String> aliments;



  FoodOffer({this.typeOfFood, this.aliments});


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


}
