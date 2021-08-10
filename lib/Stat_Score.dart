//import 'dart:ffi';
import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'providers/authentification.dart';

double cero;
double one;
double two;
double three;
double four;
double five;
double six;
double themax;
double ult;
DateTime now = new DateTime.now();
final DateFormat formato = DateFormat('EEEE');
String dayformat = formato.format(now);

// ignore: must_be_immutable
class StatScore extends StatefulWidget {
  List<dynamic> list;
  StatScore({Key key, this.list}) : super(key: key);

  @override
  _CaloriesState createState() => _CaloriesState(list2: list);
}

class _CaloriesState extends State<StatScore> {
  List<dynamic> list2;
  _CaloriesState({this.list2});
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserModel>(context, listen: false).userID);
    if (Provider.of<UserModel>(context, listen: false).userID == null)
      return FutureBuilder<bool>(
          future: AuthProvider.getUser(context),
          builder: (context, AsyncSnapshot<bool> future) {
            if (future.hasData) {
              if (future.data)
                return StatScorePage(thelist: list2);
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
      return StatScorePage(thelist: list2);
  }
}

// ignore: must_be_immutable
class StatScorePage extends StatelessWidget {
  List<dynamic> thelist;
  StatScorePage({Key key, this.thelist}) : super(key: key);
  List<Color> gradientColors = [Color(0xff23b6e6), Color(0xff02d39a)];

  @override
  Widget build(BuildContext context) {
    List<String> thestrings = [];
    for (int i = 0; i < thelist.length; i++) {
      // Apply formatting to the string if necessary
      thestrings.add(thelist[i].toStringAsFixed(2));
      print('Los STRINGS son: ${thestrings[i]}');
    }
    cero = double.parse(thestrings[6]);
    one = double.parse(thestrings[5]);
    two = double.parse(thestrings[4]);
    three = double.parse(thestrings[3]);
    four = double.parse(thestrings[2]);
    five = double.parse(thestrings[1]);
    six = double.parse(thestrings[0]);

    assert(cero is double);
    assert(one is double);
    assert(two is double);
    assert(three is double);
    assert(four is double);
    assert(five is double);
    assert(six is double);

    themax = thelist[0].roundToDouble();
    for (int i = 0; i < thelist.length; i++) {
      if (thelist[i] > themax) themax = thelist[i];
    }
    ult = themax + 1;
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else {
      return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1543352634-a1c51d9f1fa7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2560&q=80'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getDirectionsBar(context, 'Stats'),
                Text(
                  'Estadísticas de los últimos 7 días \n                   Puntuación',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30.0,
                      fontFamily: 'Mont'),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                    padding: EdgeInsets.fromLTRB(40, 70, 10, 10),
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                          //borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: 6,
                          minY: 0,
                          maxY: 5,
                          titlesData: LineTitles.getTitleData(),
                          axisTitleData: FlAxisTitleData(
                            leftTitle: AxisTitle(
                                showTitle: true,
                                titleText: 'Puntuación',
                                textStyle: TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                margin: 10),
                            bottomTitle: AxisTitle(
                                showTitle: true,
                                margin: 10,
                                titleText: 'Días',
                                textStyle: TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                )),
                          ),
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: const Color(0xFFBDBDBD),
                                strokeWidth: 1,
                              );
                            },
                            drawVerticalLine: true,
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: const Color(0xFFBDBDBD),
                                strokeWidth: 1,
                              );
                            },
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: const Color(0xFFBDBDBD),
                              width: 1,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, cero),
                                FlSpot(1, one),
                                FlSpot(2, two),
                                FlSpot(3, three),
                                FlSpot(4, four),
                                FlSpot(5, five),
                                FlSpot(6, six),
                              ],
                              isCurved: true,
                              colors: gradientColors,
                              barWidth: 6,
                              belowBarData: BarAreaData(
                                show: true,
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.35))
                                    .toList(),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    // ROW OF BUTTONS----------------
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      MaterialButton(
                          child: Text(
                            'Atrás',
                            style: new TextStyle(fontSize: 18),
                          ),
                          height: 50,
                          minWidth: 140,
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
              ],
            )),
      );
    }
  }
}

class LineTitles {
  static getTitleData() => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 100,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xFF212121),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        getTitles: (value){
          const translation = ['Lunes' , 'Martes','Miercoles','Jueves','Vieres','Sabado','Domingo']; 
          const week = ['Monday','Tuesday','Wednesday','Truesday','Friday','Saturday','Sunday'];
          return translation.elementAt((week.indexOf((dayformat))+value.toInt()+1)%7);
        },
        margin: 20,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xFF212121),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        // ignore: missing_return
        getTitles: (value) => value.toStringAsFixed(0),
        reservedSize: 80,
        margin: 20,
      ),
      rightTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xFF212121),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return "";
            case 1:
              return "";
            case 2:
              return "";
            case 3:
              return "";
            case 4:
              return "";
            case 5:
              return "";
            case 6:
              return "";
            case 7:
              return "";
            case 8:
              return "";
            case 9:
              return "";
            case 10:
              return "";
            case 11:
              return "";
            case 12:
              return "";
            case 13:
              return "";
            case 14:
              return "";
            case 15:
              return "";
            case 16:
              return "";
          }

          return '';
        },
        reservedSize: 90,
      ));
}
