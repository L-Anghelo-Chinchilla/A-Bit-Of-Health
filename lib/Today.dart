import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/providers/authentification.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Today extends StatefulWidget {
  Today({Key key}) : super(key: key);

  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserModel>(context, listen: false).userID);
    if (Provider.of<UserModel>(context, listen: false).userID == null)
      return FutureBuilder<bool>(
          future: AuthProvider.getUser(context),
          builder: (context, AsyncSnapshot<bool> future) {
            if (future.hasData) {
              if (future.data)
                return TodayPage();
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
      return TodayPage();
  }
}

class TodayPage extends StatefulWidget {
  const TodayPage({Key key}) : super(key: key);

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    FoodProvider provider = FoodProvider();
    // provider.uploadUserRegiter('-wqweqwewqeqwewq', '2021/5/12', FoodRegister(date : '4546546'));
    // if(Provider.of<UserModel>(context).userID == null )
    // return Login();
    // else

    return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1478144592103-25e218a04891?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2560&q=80'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'Today'),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: FutureBuilder(
                  future: provider.getUserRegister(
                      Provider.of<UserModel>(context, listen: false).userID,
                      DateTime.now()
                          .toString()
                          .split(' ')
                          .first
                          .replaceAll('-', '/')),
                  builder: (context, data) {
                    if (data.hasData) if (data.data.isEmpty) {
                      UserProvider().addToTodaysScore(
                          Provider.of<UserModel>(context, listen: false).userID,
                          0);
                      return getNoFoodSignal();
                    } else
                      return TodayRegister(map: data.data);
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
    return Container(
      padding: EdgeInsets.all(10.0),
      height: double.infinity,
      width: MediaQuery.of(context).size.width/2.1,
      color: Color(0xFFFEF9E7).withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Oops! Parece que no has registrado nada aún.',
            style: TextStyle(fontSize: 30),
            //textAlign: TextAlignVertical.center,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Image.asset(
              'assets/patata.png',
            ),
          )),
          /*ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'FoodSelector');
              },
              child: Text('Añadir comida'))*/
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TodayRegister extends StatefulWidget {
  TodayRegister({Key key, this.map}) ;
  Map<String, FoodRegister> map;

  @override
  _TodayRegisterState createState() => _TodayRegisterState();
}

class _TodayRegisterState extends State<TodayRegister> {

  @override
  Widget build(BuildContext context) {
    final caloriesSum = widget.map.values
        .fold(0, (previousValue, element) => previousValue + element.calories);
    double todayScore = widget.map.values
        .fold(0, (previousValue, element) => previousValue + element.score);
    todayScore = (todayScore + 0.0) / widget.map.length;

    UserProvider().addToTodaysScore(
        Provider.of<UserModel>(context, listen: false).userID,
        todayScore.toDouble());

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getScoreView(
            'Calorías del día',
            '${caloriesSum.toStringAsFixed(1)}',
          ),
          getScoreView(
            'Puntuación del día',
            '${todayScore.toStringAsFixed(1)}',
          ),
        ],
      ),
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFEF9E7).withOpacity(0.8),
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: Scrollbar(
                thickness: 13,
                //controller: _controller ,
                isAlwaysShown: true,
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: widget.map.length,
                  itemBuilder: (context, i) {
                    final len = widget.map.length;
                    return getRegisterList(context,
                        widget.map.values.elementAt(len - 1 - i), true);
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
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.amber,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Center(
              child: Text(
            score,
            style: TextStyle(fontSize: 30, fontFamily: 'Mont2'),
          )),
        ),
        Text(title, style: TextStyle(fontSize: 30, fontFamily: 'Mont2'))
      ],
    );
  }
}

Widget getRegisterList(
    BuildContext context, FoodRegister foodRegister, bool canDelete) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.fromLTRB(5, 5, 20, 5),
          decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: Colors.black45),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
                ' ${foodRegister.food.typeOfFood} ${getEmoji(foodRegister.food.typeOfFood)}',
                style: TextStyle(fontFamily: 'Pt', fontSize: 24)),
            Text('🕰️ ${foodRegister.date}, ${foodRegister.time}',
                style: TextStyle(fontFamily: 'Pt', fontSize: 20)),
            (canDelete)
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      showAlertDialog(
                          context,
                          Provider.of<UserModel>(context, listen: false).userID,
                          foodRegister.date,
                          foodRegister.id);
                      double cal = await UserProvider().getAllTodayCalories(
                          Provider.of<UserModel>(context, listen: false)
                              .userID);
                      cal -= foodRegister.calories;
                      UserProvider().addToTodaysCalories(
                          Provider.of<UserModel>(context, listen: false).userID,
                          cal);
                    })
                : Container(
                    height: 35,
                  )
          ])),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 250,
          width: double.infinity, // 500,
          child: SingleChildScrollView(
            child: DataTable(
                columns: [
                  DataColumn(
                    label: Text('Alimento(s)', style: TextStyle(fontSize: 18)),
                  ),
                  DataColumn(
                      label:
                          Text('Porción(es)', style: TextStyle(fontSize: 18))),
                  DataColumn(
                      label: Text('Calorías', style: TextStyle(fontSize: 18))),
                ],
                rows: foodRegister.food.aliments
                    .map((element) => DataRow(cells: [
                          DataCell(Text(element.name,
                              style: TextStyle(fontSize: 15))),
                          DataCell(Text('${element.cant}',
                              style: TextStyle(fontSize: 15))),
                          DataCell(Text(
                              '${(element.calories * element.cant).toStringAsFixed(1)}',
                              style: TextStyle(fontSize: 15)))
                        ]))
                    .toList()),
          ),
        ),
      ),
      Row(
        children: [
          Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color(0xFFF4D03F),
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              padding: EdgeInsets.all(10),
              child: Text(
                  'Total de calorías: ${foodRegister.calories.toStringAsFixed(1)}',
                  style: TextStyle(fontFamily: 'Pt', fontSize: 20))),
          SizedBox(
            width: 10,
          ),
          Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color(0xFFF4D03F),
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              padding: EdgeInsets.all(10),
              child: Text('Puntuación total: ${foodRegister.score}',
                  style: TextStyle(fontFamily: 'Pt', fontSize: 20)))
        ],
      ),
      Divider()
    ],
  );
}

String getEmoji(type) {
  switch (type) {
    case 'Desayuno':
      return '☕';
    case 'Almuerzo':
      return '🥣';
    case 'Cena':
      return '🥗';
    case 'Snack':
      return '🍟';
    default:
      return '';
  }
}

showAlertDialog(
    BuildContext context, String userID, String date, String registerID) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Eliminar"),
    onPressed: () async {
      final provider = FoodProvider();
      await provider.deleteRegisterByDate(userID, date, registerID);

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'Today');
    },
  );
  
  
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Eliminar registro"),
    content: Text("¿Eliminar éste registro de comida?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
