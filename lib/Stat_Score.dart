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

class Stat_Score extends StatefulWidget {
  List<dynamic> list;
  Stat_Score({Key key, this.list}) : super(key: key);

  @override
  _CaloriesState createState() => _CaloriesState(list2: list);
}

class _CaloriesState extends State<Stat_Score> {
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
                return Stat_Score_Page(thelist: list2);
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
      return Stat_Score_Page(thelist: list2);
  }
}

class Stat_Score_Page extends StatelessWidget {
  List<dynamic> thelist;
  Stat_Score_Page({Key key, this.thelist}) : super(key: key);
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
                  image: AssetImage('fondo_estadisticas.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getDirectionsBar(context, 'Stats'),
                Text(
                  'Estadisticas de los ultimos 7 dias \n                   Puntuacion',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 32.0),
                ),
                Expanded(
                  child: Container(
                    // color: Color(0xFFC5CAE9),
                    padding: EdgeInsets.all(10),
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
                                titleText: 'Puntiación',
                                textStyle: TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                margin: 10),
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
                                    .map((color) => color.withOpacity(0.3))
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
                            style: new TextStyle(fontSize: 22),
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
          fontSize: 16,
        ),
        getTitles: (value) {
          if (dayformat == "Friday") {
            switch (value.toInt()) {
              case 0:
                return "Sabado";
              case 1:
                return "Domingo";
              case 2:
                return "Lunes";
              case 3:
                return "Martes";
              case 4:
                return "Miercoles";
              case 5:
                return "jueves";
              case 6:
                return "Viernes";
            }
          } else {
            if (dayformat == "Saturday") {
              switch (value.toInt()) {
                case 0:
                  return "Domingo";
                case 1:
                  return "Lunes";
                case 2:
                  return "Martes";
                case 3:
                  return "Miercoles";
                case 4:
                  return "Jueves";
                case 5:
                  return "Viernes";
                case 6:
                  return "Sabado";
              }
            } else {
              if (dayformat == "Sunday") {
                switch (value.toInt()) {
                  case 0:
                    return "Lunes";
                  case 1:
                    return "Martes";
                  case 2:
                    return "Miercoles";
                  case 3:
                    return "Jueves";
                  case 4:
                    return "Viernes";
                  case 5:
                    return "Sabado";
                  case 6:
                    return "Domingo";
                }
              } else {
                if (dayformat == "Monday") {
                  switch (value.toInt()) {
                    case 0:
                      return "Martes";
                    case 1:
                      return "Miercoles";
                    case 2:
                      return "Jueves";
                    case 3:
                      return "Viernes";
                    case 4:
                      return "Sabado";
                    case 5:
                      return "Domingo";
                    case 6:
                      return "Lunes";
                  }
                } else {
                  if (dayformat == "Tuesday") {
                    switch (value.toInt()) {
                      case 0:
                        return "Miercoles";
                      case 1:
                        return "Jueves";
                      case 2:
                        return "Viernes";
                      case 3:
                        return "Sabado";
                      case 4:
                        return "Domingo";
                      case 5:
                        return "Lunes";
                      case 6:
                        return "Martes";
                    }
                  } else {
                    if (dayformat == "Wednesday") {
                      switch (value.toInt()) {
                        case 0:
                          return "Jueves";
                        case 1:
                          return "Viernes";
                        case 2:
                          return "Sabado";
                        case 3:
                          return "Domingo";
                        case 4:
                          return "Lunes";
                        case 5:
                          return "Martes";
                        case 6:
                          return "Miercoles";
                      }
                    } else {
                      if (dayformat == "Thursday") {
                        switch (value.toInt()) {
                          case 0:
                            return "Viernes";
                          case 1:
                            return "Sabado";
                          case 2:
                            return "Domingo";
                          case 3:
                            return "Lunes";
                          case 4:
                            return "Martes";
                          case 5:
                            return "Miercoles";
                          case 6:
                            return "Jueves";
                        }
                      }
                    }
                  }
                }
              }
            }
          }

          return '';
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
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return "0";
            case 1:
              return "1";
            case 2:
              return "2";
            case 3:
              return "3";
            case 4:
              return "4";
            case 5:
              return "5";
          }

          return '';
        },
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
