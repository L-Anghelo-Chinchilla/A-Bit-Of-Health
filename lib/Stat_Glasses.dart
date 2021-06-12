import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class Stat_Glasses extends StatelessWidget {
  Stat_Glasses({Key key}) : super(key: key);
  List<Color> gradientColors = [Color(0xff23b6e6), Color(0xff02d39a)];
  List<FlSpot> _list = [
    FlSpot(1, 1),
    FlSpot(2, 3),
    FlSpot(3, 5),
    FlSpot(4, 7),
    FlSpot(5, 6),
    FlSpot(6, 2),
    FlSpot(7, 6),
  ];

  @override
  Widget build(BuildContext context) {
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else {
      return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('fondo_Stats.jpg'), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getDirectionsBar(context, 'Stats'),
                Text(
                  '     Estadisticas de los ultimos 7 dias \n                  Vasos de agua',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 32.0),
                ),
                Expanded(
                  child: Container(
                    //color: Color(0xFFC5CAE9),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                          //borderData: FlBorderData(show: false),
                          minX: 1,
                          maxX: 7,
                          minY: 1,
                          maxY: 8,
                          titlesData: LineTitles.getTitleData(),
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
                              spots: _list,
                              isCurved: true,
                              colors: gradientColors,
                              barWidth: 5,
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
          switch (value.toInt()) {
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
          fontSize: 16,
        ),
        // ignore: missing_return
        getTitles: (value) {
          switch (value.toInt()) {
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
          }

          return '';
        },
        reservedSize: 100,
        margin: 20,
      ));
}
