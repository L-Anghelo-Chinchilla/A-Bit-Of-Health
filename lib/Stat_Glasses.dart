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
final DateFormat format1 = DateFormat('EEEE');
String dayformat = format1.format(now);
List<String> thedaysESP = [
  "Lunes",
  "Martes",
  "Miércoles",
  "Jueves",
  "Viernes",
  "Sábado",
  "Domingo"
];
List<String> thedaysENG = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
int index = thedaysENG.indexOf(dayformat);
//List<String> theorder;

// ignore: must_be_immutable
class StatGlasses extends StatefulWidget {
  List<dynamic> list;
  StatGlasses({Key key, this.list}) : super(key: key);

  @override
  _CaloriesState createState() => _CaloriesState(list2: list);
}

class _CaloriesState extends State<StatGlasses> {
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
                return StatGlassesPage(thelist: list2);
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
      return StatGlassesPage(thelist: list2);
  }
}

// ignore: must_be_immutable
class StatGlassesPage extends StatelessWidget {
  List<dynamic> thelist;
  StatGlassesPage({Key key, this.thelist}) : super(key: key);
  List<Color> gradientColors = [Color(0xff23b6e6), Color(0xff02d39a)];

  @override
  Widget build(BuildContext context) {
    cero = thelist[6];
    one = thelist[5];
    two = thelist[4];
    three = thelist[3];
    four = thelist[2];
    five = thelist[1];
    six = thelist[0];
    themax = thelist[0];
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
                  'Estadísticas de los últimos 7 días \n                  Vasos de agua',
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
                          //minX:1,
                          //  maxX:7,
                          minY: 0,
                          maxY: 15,
                          titlesData: LineTitles.getTitleData(),
                          axisTitleData: FlAxisTitleData(
                            leftTitle: AxisTitle(
                                showTitle: true,
                                titleText: 'Vasos',
                                textStyle: TextStyle(
                                  color: Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
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
        getTitles: (value) {
          if (dayformat == "Friday") {
            switch (value.toInt()) {
              case 0:
                return "Sábado";
              case 1:
                return "Domingo";
              case 2:
                return "Lunes";
              case 3:
                return "Martes";
              case 4:
                return "Miércoles";
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
                  return "Miércoles";
                case 4:
                  return "Jueves";
                case 5:
                  return "Viernes";
                case 6:
                  return "Sábado";
              }
            } else {
              if (dayformat == "Sunday") {
                switch (value.toInt()) {
                  case 0:
                    return "Lunes";
                  case 1:
                    return "Martes";
                  case 2:
                    return "Miércoles";
                  case 3:
                    return "Jueves";
                  case 4:
                    return "Viernes";
                  case 5:
                    return "Sábado";
                  case 6:
                    return "Domingo";
                }
              } else {
                if (dayformat == "Monday") {
                  switch (value.toInt()) {
                    case 0:
                      return "Martes";
                    case 1:
                      return "Miércoles";
                    case 2:
                      return "Jueves";
                    case 3:
                      return "Viernes";
                    case 4:
                      return "Sábado";
                    case 5:
                      return "Domingo";
                    case 6:
                      return "Lunes";
                  }
                } else {
                  if (dayformat == "Tuesday") {
                    switch (value.toInt()) {
                      case 0:
                        return "Miércoles";
                      case 1:
                        return "Jueves";
                      case 2:
                        return "Viernes";
                      case 3:
                        return "Sábado";
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
                          return "Sábado";
                        case 3:
                          return "Domingo";
                        case 4:
                          return "Lunes";
                        case 5:
                          return "Martes";
                        case 6:
                          return "Miércoles";
                      }
                    } else {
                      if (dayformat == "Thursday") {
                        switch (value.toInt()) {
                          case 0:
                            return "Viernes";
                          case 1:
                            return "Sábado";
                          case 2:
                            return "Domingo";
                          case 3:
                            return "Lunes";
                          case 4:
                            return "Martes";
                          case 5:
                            return "Miércoles";
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
            case 6:
              return "6";
            case 7:
              return "7";
            case 8:
              return "8";
            case 9:
              return "9";
            case 10:
              return "10";
            case 11:
              return "11";
            case 12:
              return "12";
            case 13:
              return "13";
            case 14:
              return "14";
            case 15:
              return "15";
          }

          return '';
        },
        reservedSize: 120,
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
