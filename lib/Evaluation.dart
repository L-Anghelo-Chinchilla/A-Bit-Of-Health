import 'package:a_bit_of_health/FoodSelector.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:intl/intl.dart';
import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int score = 1;
double reciprocal(double d) => 1 / d;

class Evaluation extends StatelessWidget {
  Evaluation({Key key}) : super(key: key);
  FoodProvider _provider = FoodProvider();

  @override
  Widget build(BuildContext context) {
    Tuple2<double, FoodOffer> thelist =
        ModalRoute.of(context).settings.arguments;

    if (thelist == null) return FoodSelector();
    String kindoffood = thelist.item2.typeOfFood;
    String thetotal = thelist.item1.toStringAsFixed(1);
    List<Food> flist = thelist.item2.aliments;

    int healthyQuantity;

    String lastRegister = "0";

    switch (kindoffood) {
      case "Desayuno":
        lastRegister =
            Provider.of<UserModel>(context, listen: false).getLastBreakfast();
        healthyQuantity = 625;
        break;
      case "Almuerzo":
        lastRegister =
            Provider.of<UserModel>(context, listen: false).getLastLunch();
        healthyQuantity = 875;
        break;
      case "Cena":
        lastRegister =
            Provider.of<UserModel>(context, listen: false).getLastDinner();
        healthyQuantity = 750;
        break;
      case "Snack":
        lastRegister =
            Provider.of<UserModel>(context, listen: false).getLastSnack();
        healthyQuantity = 250;
        break;
    }

    // print('La lista es ${flist[0].name}');

    return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1586985290301-8db40143d525?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'Evaluation'),
              Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\n Puntuar Comidas',
                              style: TextStyle(
                                fontFamily: 'Mont',
                                fontSize: 32,
                              ),
                            ),

                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      //THE CONTAINER IN YELLOW
                                      width: 800,
                                      height: 420,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF4D03F)
                                              .withOpacity(0.8),
                                          border:
                                              Border.all(color: Colors.black)),
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Tu comida: ${kindoffood}',
                                                style: TextStyle(
                                                  fontFamily: 'Mont',
                                                  fontSize: 24,
                                                ),
                                              )),
                                          SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'ALIMENTO',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Mont2',
                                                        fontSize: 19,
                                                      ),
                                                    )),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '     PORCIONES',
                                                      style: TextStyle(
                                                          fontFamily: 'Mont2',
                                                          fontSize: 19,
                                                          color: Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'CAL/PORC.',
                                                      style: TextStyle(
                                                          fontFamily: 'Mont2',
                                                          fontSize: 19,
                                                          color: Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ))
                                              ]),
                                          Container(
                                              width: 800,
                                              height: 310,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              child: Scrollbar(
                                                  isAlwaysShown: true,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: flist.length,
                                                    itemBuilder: (context, i) {
                                                      return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 1,
                                                                  vertical: 10),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Container(
                                                                          width:
                                                                              200,
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child:
                                                                              Text(
                                                                            '${flist[i].name}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Mont3',
                                                                                fontSize: 15,
                                                                                color: Colors.black),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          )),
                                                                      Container(
                                                                          width:
                                                                              40,
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child:
                                                                              Text(
                                                                            '${flist[i].cant}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Mont3',
                                                                                fontSize: 15,
                                                                                color: Colors.black),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          )),
                                                                      Container(
                                                                          width:
                                                                              40,
                                                                          alignment: Alignment
                                                                              .center,
                                                                          child:
                                                                              Text(
                                                                            '${flist[i].calories}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Mont3',
                                                                                fontSize: 15,
                                                                                color: Colors.black),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          )),
                                                                    ])
                                                              ]));
                                                    },
                                                  )))
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 500,
                                          height: 200,
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFDC7633).withOpacity(
                                                  0.8), //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                                              border: Border.all(
                                                  color: Colors.black)),
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            children: [
                                              Text(
                                                '\nTu última comida de ${kindoffood} contuvo: ${lastRegister} calorías.',
                                                style: TextStyle(
                                                  fontFamily: 'Mont2',
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Expanded(
                                                  child: SizedBox(
                                                      height: 200.0,
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          Container(
                                                              child: Text(
                                                            '\nTu comida \nActual Contiene:',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mont',
                                                              fontSize: 21,
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            width: 50,
                                                          ),
                                                          Container(
                                                              child: Text(
                                                            '\n\n ${thetotal} Calorías',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mont',
                                                              fontSize: 26,
                                                            ),
                                                          )),
                                                        ],
                                                      )))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 500,
                                          height: 200,
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF5B041)
                                                  .withOpacity(0.9),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            children: [
                                              if (kindoffood == 'Cena')
                                                Text(
                                                  '\nUna ${kindoffood} para ser balanceada, debería contener aproximadamente ${healthyQuantity} cal. Entonces....',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont2',
                                                    fontSize: 18,
                                                  ),
                                                )
                                              else
                                                Text(
                                                  '\nUn ${kindoffood} para ser balanceado, debería contener aproximadamente ${healthyQuantity} cal. Entonces....',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Mont2',
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              Text(
                                                '\n¿Cómo puntuarías tu comida?',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Mont',
                                                  fontSize: 22,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Expanded(
                                                  child: Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                    height: 20,
                                                    width: 80,
                                                    child: CounterView()),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                // ROW OF BUTTONS----------------
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.max,
                                children: [
                                  MaterialButton(
                                      child: Text(
                                        'Atrás',
                                        style: new TextStyle(fontSize: 22),
                                      ),
                                      height: 50,
                                      minWidth: 140,
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  SizedBox(
                                    child: Container(),
                                    width: 500,
                                  ),
                                  MaterialButton(
                                      child: Text('Finalizar',
                                          style: new TextStyle(fontSize: 22)),
                                      height: 50,
                                      minWidth: 140,
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      //backgroundColor: Colors.limeAccent[700],
                                      onPressed: () async {
                                        UpdateFood(
                                            kindoffood, thetotal, context);

                                        //THE USER REGISTER
                                        UploadRegister(
                                            _provider,
                                            context,
                                            score,
                                            thelist.item1,
                                            thelist.item2);
                                        //EXTRACT OF THE OTHER DAYS CALORIES
                                        String userID = Provider.of<UserModel>(
                                                context,
                                                listen: false)
                                            .userID;

                                        double cal = await UserProvider()
                                            .getAllTodayCalories(
                                                Provider.of<UserModel>(context,
                                                        listen: false)
                                                    .userID);
                                        cal += thelist.item1;
                                        UserProvider().addToTodaysCalories(
                                            Provider.of<UserModel>(context,
                                                    listen: false)
                                                .userID,
                                            cal);
                                        //CLEAR THE LIST
                                        Provider.of<List<FoodOffer>>(context,
                                                listen: false)
                                            .clear();

                                        print(
                                            'Lo siguiente debería estar vacío -> ' +
                                                Provider.of<List<FoodOffer>>(
                                                        context,
                                                        listen: false)
                                                    .toString());
                                        flist = [];
                                        kindoffood = "";
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          'Today',
                                          ModalRoute.withName('FoodSelector'),
                                        );
                                        //   await Navigator.pushReplacementNamed(context, 'Today');
                                        print('Evaluation envía: ${score}');
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Tu registro se ha guardado'),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        print(
                                            'La puntuación del usuario es ${score}');
                                      }),
                                ],
                              ),
                            ), //-
                          ])))
            ],
          ),
        ));
  }
}

void UpdateFood(
    String kindOfFood, String thetotal, BuildContext context) async {
  switch (kindOfFood) {
    case "Desayuno":
      Provider.of<UserModel>(context, listen: false).setLastBreakfast(thetotal);
      await UserProvider().updateTodayCalories(
          Provider.of<UserModel>(context, listen: false).userID,
          kindOfFood,
          thetotal);
      break;
    case "Almuerzo":
      Provider.of<UserModel>(context, listen: false).setLastLunch(thetotal);
      await UserProvider().updateTodayCalories(
          Provider.of<UserModel>(context, listen: false).userID,
          kindOfFood,
          thetotal);
      break;
    case "Cena":
      Provider.of<UserModel>(context, listen: false).setLastDinner(thetotal);
      await UserProvider().updateTodayCalories(
          Provider.of<UserModel>(context, listen: false).userID,
          kindOfFood,
          thetotal);
      break;
    case "Snack":
      Provider.of<UserModel>(context, listen: false).setLastSnack(thetotal);
      await UserProvider().updateTodayCalories(
          Provider.of<UserModel>(context, listen: false).userID,
          kindOfFood,
          thetotal);
      break;
  }
}

void UploadRegister(FoodProvider _provider, BuildContext context, int score,
    double thecalories, FoodOffer thefood) {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy/MM/dd');
  final String formatted = formatter.format(now);

  final DateFormat thetime = DateFormat('hh:mm:ss');
  final String times = thetime.format(now);

  String userID = Provider.of<UserModel>(context, listen: false).userID;

  _provider.uploadUserRegiter(
      userID,
      formatted,
      FoodRegister(
          score: score,
          calories: thecalories,
          time: times,
          date: formatted,
          food: thefood));

  final food = FoodRegister(
      score: score,
      calories: thecalories,
      time: times,
      date: formatted,
      food: thefood);
  print(food.foodRegisterToJson(food));

  UserProvider()
      .updateDailyScore(Provider.of<UserModel>(context, listen: false).userID);
}

class CounterView extends StatefulWidget {
  final int initNumber;
  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  CounterView(
      {this.initNumber,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int _currentCount;
  Function _counterCallback;
  Function _increaseCallback;
  Function _decreaseCallback;

  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createIncrementDicrementButton(Icons.remove, () => _dicrement()),
          Text(_currentCount.toString()),
          _createIncrementDicrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      if (_currentCount < 5) _currentCount++;
      _counterCallback(_currentCount);
      _increaseCallback();
      score = _currentCount;
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
        score = _currentCount;
      }
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.limeAccent[700],
      child: Icon(
        icon,
        color: Colors.white,
        size: 12.0,
      ),
      shape: CircleBorder(),
    );
  }
}
