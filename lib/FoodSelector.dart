import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:flutter/material.dart';

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
        body: Column(children: [
          Text('Añadir comida'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            
              Text('¿Qué estás comiendo?'),
      DropdownButton<String>(
        value: foodSelected,
        items: items,
        onChanged: (String newValue) {
          foodSelected = newValue;
          setState(() {});
        },
      ),]),
      Container(
          width: 1000,
          height: 500,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
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
    ]));
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
      itemBuilder: (context, i) {
        return Container(
            margin: EdgeInsets.all(15),
            height: 200,
            width: 200,
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
      Container(
          height: 300,
          decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.aliments.length,
            itemBuilder: (context, i) {
              return CheckboxListTile(
                  title: Text(list.aliments[i]),
                  value: false,
                  onChanged: (value) {});
            },
          ))
    ]));
  }
}

/*







class FoodCounter extends StatelessWidget {
  const FoodCounter({Key key}) : super(key: key);

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
     //String _formatdate = new DateFormat.yMMMd().format(_currentDate);

       Center(child: Icon(Icons.analytics)),
       Center(child: Icon(Icons.calendar_today_rounded)),
      const Center(child: Icon(Icons.star)),
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


*/
