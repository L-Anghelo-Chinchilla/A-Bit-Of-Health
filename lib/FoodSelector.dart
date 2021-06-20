import 'dart:ui';

import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/authentification.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:tuple/tuple.dart';

import 'models/UserModel.dart';

class FoodSelector extends StatefulWidget {
  const FoodSelector({Key key}) : super(key: key);

  @override
  _FoodSelectorState createState() => _FoodSelectorState();
}

class _FoodSelectorState extends State<FoodSelector> {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserModel>(context, listen: false).userID);
    if (Provider.of<UserModel>(context, listen: false).userID == null)
      return FutureBuilder<bool>(
          future: AuthProvider.getUser(context),
          builder: (context, AsyncSnapshot<bool> future) {
            if (future.hasData) {
              if (future.data)
                return FoodSelectorPage();
              else
                return Login();
            } else {
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 250,
                width: 250,
              ));
            }
          });
    else
      return FoodSelectorPage();
  }
}

class FoodSelectorPage extends StatefulWidget {
  FoodSelectorPage({Key key}) : super(key: key);

  @override
  _FoodSelectorStatePage createState() => _FoodSelectorStatePage();
}

class _FoodSelectorStatePage extends State<FoodSelectorPage> {
  FoodProvider _provider = FoodProvider();
  FoodOfferModel _offer;
  String foodSelected = 'Desayuno';
  final items = ['Desayuno', 'Almuerzo', 'Cena', 'Snack']
      .map((value) => DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontFamily: 'Pt', fontSize: 19.0),
          ))) //XXXXXXXXXXXXXXXXXXXXXXXXXX
      .toList();

  @override
  Widget build(BuildContext context) {
    UserProvider user = UserProvider();
    //
    return Scaffold(
        appBar: getAppBar(context: context),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          getDirectionsBar(context, 'FoodSelector'),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/fondo_selector.jpg'),
                      fit: BoxFit.cover),
                ),
                // child:// SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                child: Container(
                    /*decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fondo_selector.jpg'),
                            fit: BoxFit.cover
                          ),
                        ),*/
                    padding: EdgeInsets.all(17),
                    child: Column(children: [
                      Text(
                        'Añadir comida',
                        style: TextStyle(fontFamily: 'Mont', fontSize: 32.0),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿Qué estás comiendo?  ',
                              style:
                                  TextStyle(fontFamily: 'Sans', fontSize: 20.0),
                            ),
                            DropdownButton<String>(
                              value: foodSelected,
                              items: items,
                              onChanged: (String newValue) {
                                foodSelected = newValue;
                                setState(() {});
                              },
                            ),
                          ]),
                      Expanded(
                          child: Container(
                              // width: MediaQuery.of(context).size.width * 0.8,
                              height: double
                                  .infinity, // MediaQuery.of(context).size.height * 0.6,
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Color(0xffffffff).withOpacity(0.8),
                                  border: Border.all(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: FutureBuilder<FoodOfferModel>(
                                  future: _provider.getFoodOffers(foodSelected),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<FoodOfferModel> snapshot) {
                                    if (snapshot.hasData) {
                                      Provider.of<FoodOfferModel>(context,
                                              listen: false)
                                          .setFoodOffers(
                                              snapshot.data.foodOffers);

                                      return FoodOfferList(
                                          offer: snapshot.data);
                                    } else {
                                      return SizedBox(
                                        child: CircularProgressIndicator(),
                                        width: 60,
                                        height: 60,
                                      );
                                    }
                                  }))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: Text('Siguiente',
                                style: TextStyle(fontSize: 18)),
                            onPressed: () {
                              List<FoodOffer> list = [];
                              list = Provider.of<FoodOfferModel>(context,
                                      listen: false)
                                  .getSelectedOnes();
                              list.removeWhere(
                                  (element) => element.aliments.isEmpty);
                              if (list.isNotEmpty) {
                                Navigator.pushNamed(context, 'FoodCounter',
                                    arguments: Tuple2<String, List<FoodOffer>>(
                                        foodSelected, list));
                                Provider.of<FoodOfferModel>(context,
                                        listen: false)
                                    .foodOffers
                                    .forEach((element) {
                                  element.deselectAll();
                                  Provider.of<List<FoodOffer>>(context,
                                          listen: false)
                                      .clear(); //MARKER
                                  setState(() {});
                                  print('FoodSelector envía: ${list}');
                                });
                              } else {
                                final snackBar = SnackBar(
                                  content: Text(
                                      'Has seleccionado nada! El aire no cuenta como comida... '),
                                  action: SnackBarAction(
                                    label: 'Vale!',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          )
                        ],
                      )
                    ]))),
          ) //)
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
    return Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: Provider.of<FoodOfferModel>(context, listen: false)
            .foodOffers
            .length,
        itemBuilder: (context, i) {
          return Container(
              color: Color(0xFF76D7C4),
              margin: EdgeInsets.all(15),
              width: 235, //MediaQuery.of(context).size.width*0.8 /5   ,
              child: OfferScroll(
                  list: Provider.of<FoodOfferModel>(context, listen: false)
                      .foodOffers[i],
                  position: i));
        },
      ),
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
        decoration: BoxDecoration(color: Color(0xFFDC7633)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            '${widget.list.typeOfFood}',
            style: TextStyle(fontFamily: 'Mont2', fontSize: 20.0),
          ),
          //Divider(color: Colors.white),
          Expanded(
              child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Color(0xFFF4D03F),
                      border: Border.all(color: Colors.black45)),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          Provider.of<FoodOfferModel>(context, listen: false)
                              .foodOffers[widget.position]
                              .aliments
                              .length,
                      itemBuilder: (_, i) {
                        String name =
                            Provider.of<FoodOfferModel>(context, listen: false)
                                .foodOffers[widget.position]
                                .aliments[i]
                                .name; //widget.list.aliments[i].name;
                        bool value = Provider.of<FoodOfferModel>(context,
                                listen: true)
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
                                if (name == 'Ninguno')
                                  Provider.of<FoodOfferModel>(context,
                                          listen: false)
                                      .foodOffers[widget.position]
                                      .deselectAll();
                                else
                                  Provider.of<FoodOfferModel>(context,
                                          listen: false)
                                      .foodOffers[widget.position]
                                      .aliments[0]
                                      .deselect();
                                Provider.of<FoodOfferModel>(context,
                                        listen: false)
                                    .foodOffers[widget.position]
                                    .aliments[i]
                                    .setIsSelected();

                                setState(() {});
                              });
                        });
                      },
                    ),
                  )))
        ]));
  }
}
