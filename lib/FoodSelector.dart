import 'package:a_bit_of_health/GlassesOfWater.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';

class FoodSelector extends StatelessWidget {
  const FoodSelector({Key key}) : super(key: key);

  //DateTime _currentDate = new DateTime.now();

  /*Future<Null> selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2021));
  }*/

  @override
  Widget build(BuildContext context) {

   // UserModel user = ModalRoute.of(context).settings.arguments;
    //String _formatdate = new DateFormat.yMMMd().format(_currentDate);
    final _TabPages = [
      FoodSelector2(),
      Center(child: Icon(Icons.analytics)),
      Center(child: Icon(Icons.calendar_today_rounded)),
      GlassesOfWater1(user: ModalRoute.of(context).settings.arguments,)
      //const Center(child: Icon(Icons.star)),
      //const Center(child: Text("Date: $_currentDate")),
    ];
    final _KTabs = <Tab>[
      const Tab(icon: Icon(Icons.home), text: 'Inicio'),
      const Tab(icon: Icon(Icons.analytics), text: 'Estadísticas'),
      const Tab(icon: Icon(Icons.calendar_today_rounded), text: 'Calendario'),
      const Tab(icon: Icon(Icons.star), text: 'Hoy'),
    ];
    return DefaultTabController(
      length: _KTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('A Bit Of Health'),
          backgroundColor: Colors.limeAccent[700],
          brightness: Brightness.dark,
          actions: [
            Image(
              image: AssetImage('assets/ABitOfHealth.png'),
              fit: BoxFit.contain,
              height: 60,
            )
          ],
          bottom: TabBar(
            tabs: _KTabs,
          ),
        ),
        body: TabBarView(
          children: _TabPages,
        ),
      ),
    );
  }
}

class FoodSelector2 extends StatefulWidget {
  FoodSelector2({Key key}) : super(key: key);

  @override
  _FoodSelectorState createState() => _FoodSelectorState();
}

class _FoodSelectorState extends State<FoodSelector2> {
  FoodProvider _provider = FoodProvider();
  FoodOfferModel _offer;
  String foodSelected = 'Desayuno';
  final items = ['Desayuno', 'Almuerzo', 'Cena', 'Snack']
      .map(
          (value) => DropdownMenuItem<String>(value: value, child: Text(value)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.all(17),
            child: Column(children: [
              Text('Añadir comida'),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: FutureBuilder<FoodOfferModel>(
                      future: _provider.getFoodOffers(
                          foodSelected), // a previously-obtained Future<String> or null
                      builder: (BuildContext context,
                          AsyncSnapshot<FoodOfferModel> snapshot) {
                        if (snapshot.hasData) {
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
                  ElevatedButton(child: Text('Atrás'), onPressed: () {}),
                  ElevatedButton(
                    child: Text('Siguiente'),
                    onPressed: () {},
                  )
                ],
              )
            ])));
  }
}

class FoodOfferList extends StatefulWidget {
  FoodOfferModel offer;

  FoodOfferList({Key key, this.offer}) : super(key: key);

  @override
  _FoodOfferListState createState() => _FoodOfferListState();
}

class _FoodOfferListState extends State<FoodOfferList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.offer.foodOffers.length,
      itemBuilder: (_, i) {
        return Container(
            margin: EdgeInsets.all(15),
          // height: MediaQuery.of(context).size.height * 0.4 - 20,
            width: 235, //MediaQuery.of(context).size.width*0.8 /5   ,
            child: OfferScroll(list: widget.offer.foodOffers[i]));
      },
    );
  }
}

class OfferScroll extends StatelessWidget {
  OfferScroll({this.list});

  FoodOffer list;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text('${list.typeOfFood}'),
      Divider(),
      Expanded(child:
      Container(
          height: 300,
          decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.aliments.length,
            itemBuilder: (_, i) {
            
            String name = list.aliments[i];
            bool value = false ;
              return CheckboxListTile(
                  title: Text(name),
                  value: value,
                  onChanged: (value) {
                    Provider.of<FoodOfferModel>(context,listen: false).valueChanged('Desayuno', name, value);
                    
                  
                  });
            },
          )))
    ]));
  }
}
