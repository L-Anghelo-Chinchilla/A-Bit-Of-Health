
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:flutter/material.dart';



class FoodSelector extends StatelessWidget{

    FoodProvider _provider = FoodProvider();
    FoodOfferModel _offer ;
    String foodSelected;

    void initState() async{
    }
    
    @override
    Widget build(BuildContext context){
    
      foodSelected = 'Desayuno';


      return Scaffold(

        body: Container(
          margin: EdgeInsets.all(50),
          padding: EdgeInsets.all(50),
//height:1000 ,
            //width: 1000,
            decoration: BoxDecoration(
    border: Border.all(color: Colors.black)),
          child:  FutureBuilder<FoodOfferModel>(
        future:_provider.getFoodOffers('Almuerzo'), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<FoodOfferModel> snapshot) {
          
          if (snapshot.hasData) {
            return FoodOfferList(offer:snapshot.data);


          }else{

            return SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ); 
          }
        } 
        ))
      );



    }



}


class FoodOfferList extends StatefulWidget {
  
   FoodOfferModel offer; 


  FoodOfferList({Key key , this.offer}) : super(key: key);

  @override
  _FoodOfferListState createState() => _FoodOfferListState();
}

class _FoodOfferListState extends State<FoodOfferList> {
  
    @override
    Widget build(BuildContext context){

      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.offer.foodOffers.length, 
        itemBuilder: (context,i ){
          return Container(margin: EdgeInsets.all(50),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
          border: Border.all(color: Colors.black45)),
            child:
              OfferScroll (list:widget.offer.foodOffers[i]));
          
        } ,
      
      
      
      
      
      
      );

    }

}


class OfferScroll extends StatelessWidget{




    OfferScroll({this.list});
    
    FoodOffer list; 

    @override
    Widget build(BuildContext context){
      return ListView.builder(
        shrinkWrap: true,
        itemCount: list.aliments.length,
        itemBuilder:(context, i ){
          return CheckboxListTile(
            title: Text(list.aliments[i]),
            value: false,
             onChanged:(value){}
          );


        },



      );


    }

}