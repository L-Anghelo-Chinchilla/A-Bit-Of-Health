import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';

class Evaluation extends StatelessWidget {
  Evaluation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tuple3<String, double, List<Food>> thelist =
        ModalRoute.of(context).settings.arguments;
    String kindoffood = thelist.item1;
    String thetotal = thelist.item2.toStringAsFixed(2);
    List<Food> flist = thelist.item3;

    print('La lista es ${flist[0].name}');

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
              getDirectionsBar(context, 'Evaluation'),

              Text(
                '\n Puntuar Comidas',
                style: TextStyle(
                  fontFamily: 'Mont',
                  fontSize: 50,
                ),
              ),

              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 800,
                        height: 570,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xFFF4D03F).withOpacity(0.9),
                            border: Border.all(color: Colors.black)),
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Tu comida: ',
                                  style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 20,
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                child: SizedBox(
                                    height: 200.0,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Column(
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'ALIMENTO',
                                                  style: TextStyle(
                                                    fontFamily: 'Mont',
                                                    fontSize: 20,
                                                  ),
                                                )),
                                            Container(
                                              color: Colors.red[600],
                                              width: 250,
                                              height: 450,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: flist.length,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1,
                                                              vertical: 10),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${flist[i].name}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Mont',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8)),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ]));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'PORCIONES ',
                                                  style: TextStyle(
                                                      fontFamily: 'Mont',
                                                      fontSize: 20,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Container(
                                              color: Colors.red[600],
                                              width: 250,
                                              height: 450,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: flist.length,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1,
                                                              vertical: 10),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${flist[i].cant}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Mont',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8)),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ]));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'CALORIAS ',
                                                  style: TextStyle(
                                                      fontFamily: 'Mont',
                                                      fontSize: 20,
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Container(
                                              color: Colors.red[600],
                                              width: 250,
                                              height: 450,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: flist.length,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1,
                                                              vertical: 10),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${flist[i].calories}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Mont',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8)),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ]));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )))
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 500,
                            height: 200,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4D03F).withOpacity(0.9),
                                border: Border.all(color: Colors.black)),
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Text(
                                  '\n Tu ultima comida (Tipo) contuvo: ${thetotal} cal',
                                  style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                        height: 200.0,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Container(
                                                child: Text(
                                              '\n Tu comida \nActual Contiene:',
                                              style: TextStyle(
                                                fontFamily: 'Mont',
                                                fontSize: 20,
                                              ),
                                            )),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Container(
                                                child: Text(
                                              '\n\n ${thetotal} Calorias',
                                              style: TextStyle(
                                                fontFamily: 'Mont',
                                                fontSize: 20,
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
                                color: Color(0xFFF4D03F).withOpacity(0.9),
                                border: Border.all(color: Colors.black)),
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Text(
                                  '\n Un tipo (Tipo) para ser balanceado, deberia contener aproximadamente XXXX cal',
                                  style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 20,
                                  ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        child: Text('Atrás'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        //backgroundColor: Colors.limeAccent[700],
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ), //-
            ],
          ),
        ));
  }
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
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
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
