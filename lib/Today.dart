import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  const Today({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodProvider provider = FoodProvider();
    DateTime today = DateTime.now();
    String date = '${today.year}/${today.month}/${today.day}';
    return Scaffold(
        appBar: getAppBar(context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('fondo_inicio.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'Today'),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: FutureBuilder(
                  future: provider.getUserRegister('-wqweqwewqeqwewq', date),
                  builder: (context, data) {
                    if (data.hasData) if (data.data.isEmpty)
                      return getNoFoodSignal();
                    else
                      return TodayRegister();
                    else
                      return CircularProgressIndicator();
                  },
                ),
              ))
            ],
          ),
        ));
  }

  Widget getNoFoodSignal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Oops! Parece que no has registrado nada aún.',
          style: TextStyle(fontSize: 30),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(29.0),
          child: Image.asset(
            'lib/assets/vaso_lleno.png',
          ),
        )),
        /*ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'FoodSelector');
            },
            child: Text('Añadir comida'))*/
      ],
    );
  }
}

class TodayRegister extends StatelessWidget {
  const TodayRegister({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getScoreView(
            'Calorías de día',
            '457',
          ),
          getScoreView(
            'Puntuación de día',
            '${3.5}',
          ),
        ],
      ),
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
              ),
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: 40,
                  itemBuilder: (context, i) {
                    return Register();
                  },
                ),
              )))
    ]);
  }

  Widget getScoreView(String title, String score) {
    return Column(
      children: [
        Container(
          // width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            color: Colors.amber,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Center(child: Text(score)),
        ),
        Text(title)
      ],
    );
  }
}

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('comida'),
                  Text('Hora'),
                  IconButton(
                      icon: Icon(Icons.confirmation_num), onPressed: () {})
                ])),
        Container(
          height: 250,
          width: 500,
          child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemBuilder: (context, i) {
              return Row(
                  //crossAxisAlignment: CrossAxisAlignment.star
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Comida'),
                    Text('Porción'),
                    Text('Calorias'),
                  ]);
            },
          ),
        ),
        Row(
          children: [
            Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                ),
                padding: EdgeInsets.all(10),
                child: Text('Calorias: 456')),
            SizedBox(
              width: 10,
            ),
            Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                ),
                padding: EdgeInsets.all(10),
                child: Text('Puntuación: 4.6'))
          ],
        )
      ],
    );
  }
}
