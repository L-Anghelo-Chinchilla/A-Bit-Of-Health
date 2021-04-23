import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';

class FoodSelector extends StatefulWidget {
  FoodSelector({Key key}) : super(key: key);

  @override
  _FoodSelectorState createState() => _FoodSelectorState();
}

class _FoodSelectorState extends State<FoodSelector> {
  FoodProvider _provider = FoodProvider();
  FoodOfferModel _offer;
  String foodSelected = 'Desayuno';
  final items = ['Desayuno', 'Almuerzo', 'Cena', 'Snack']
      .map(
          (value) => DropdownMenuItem<String>(value: value, child: Text(value)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          getDirectionsBar(context),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(17),
                      child: Column(children: [
                        Text('Añadir comida'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('¿Qué estás comiendo?'),
                              DropdownButton<String>(
                                value: foodSelected,
                                items: items,
                                onChanged: (String newValue) {
                                  foodSelected = newValue;
                                  setState(() {});
                                },
                              ),
                            ]),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.6,
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: FutureBuilder<FoodOfferModel>(
                                future: _provider.getFoodOffers(
                                    foodSelected), // a previously-obtained Future<String> or null
                                builder: (BuildContext context,
                                    AsyncSnapshot<FoodOfferModel> snapshot) {
                                  if (snapshot.hasData) {
                                    Provider.of<FoodOfferModel>(context,
                                            listen: false)
                                        .setFoodOffers(
                                            snapshot.data.foodOffers);
                                    return FoodOfferList(offer: snapshot.data);
                                  } else {
                                    return SizedBox(
                                      child: CircularProgressIndicator(),
                                      width: 60,
                                      height: 60,
                                    );
                                  }
                                })),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                child: Text('Atrás'), onPressed: () {}),
                            ElevatedButton(
                              child: Text('Siguiente'),
                              onPressed: () {
                                
                                List<FoodOffer> list = [];
                                list =  Provider.of<FoodOfferModel>(context,listen: false ).getSelectedOnes();
                                print(list.toString()); 
                                Navigator.pushNamed(context, 'FoodCounter', arguments:  list);
                              },
                            )
                          ],
                        ) 
                      ]))))
        ]));
  }
}

class FoodOfferList extends StatefulWidget {
  FoodOfferModel offer;
  int position;

  FoodOfferList({Key key, this.offer, this.position}) : super(key: key);

  @override
  _FoodOfferListState createState() => _FoodOfferListState();
}

class _FoodOfferListState extends State<FoodOfferList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount:
          Provider.of<FoodOfferModel>(context, listen: false).foodOffers.length,
      itemBuilder: (context, i) {
        return Container(
            margin: EdgeInsets.all(15),
            width: 235, //MediaQuery.of(context).size.width*0.8 /5   ,
            child: OfferScroll(
                list: Provider.of<FoodOfferModel>(context, listen: false)
                    .foodOffers[i],
                position: i));
      },
    );
  }
}

class OfferScroll extends StatefulWidget {
  OfferScroll({Key key, this.list, this.position}) : super(key: key);
  FoodOffer list;
  int position;

  @override
  _OfferScrollState createState() => _OfferScrollState();
}

class _OfferScrollState extends State<OfferScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text('${widget.list.typeOfFood}'),
      Divider(),
      Expanded(
          child: Container(
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black45)),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Provider.of<FoodOfferModel>(context, listen: false)
                    .foodOffers[widget.position]
                    .aliments
                    .length,
                itemBuilder: (_, i) {
                  String name =
                      Provider.of<FoodOfferModel>(context, listen: false)
                          .foodOffers[widget.position]
                          .aliments[i]
                          .name; //widget.list.aliments[i].name;
                  bool value =
                      Provider.of<FoodOfferModel>(context, listen: true)
                          .foodOffers[widget.position]
                          .aliments[i]
                          .isSelected; //widget.list.aliments[i].isSelected;
                  return Consumer<Food>(builder: (context, food, child) {

                  Food fod =
                      Provider.of<FoodOfferModel>(context, listen: true)
                          .foodOffers[widget.position]
                          .aliments[i];

                    return CheckboxListTile(
                        title: Text(name),
                        tristate: true,
                        value: fod.isSelected,
                        onChanged: (newValue) {
                          Provider.of<FoodOfferModel>(context, listen: false)
                              .foodOffers[widget.position]
                              .aliments[i]
                              .setIsSelected();
                         // value = !value;
                          print(Provider.of<FoodOfferModel>(context,
                                  listen: false)
                              .foodOffers[widget.position]
                              .aliments[i]
                              .isSelected);
                              setState(() {
                                
                              });
                        });
                  });
                },
              )))
    ]));
  }
}
