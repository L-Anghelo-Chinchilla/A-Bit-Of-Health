import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

double cero = num[0];
double one = num[1];
double two = num[2];
double three = num[3];
double four = num[4];
double five = num[5];
double six = num[6];
List<double> num= [1,3,2,1,2,3,4];
DateTime now = new DateTime.now();
final DateFormat formato = DateFormat('EEEE');
String dayformat= formato.format(now);

class Stat_Score extends StatelessWidget {
   Stat_Score({Key key}) : super(key: key);
   List<Color> gradientColors = [ Color(0xff23b6e6), Color(0xff02d39a)];

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
              //  minX:1,
               // maxX:7,
                minY:1,
                maxY:6,
                titlesData: LineTitles.getTitleData(),
                gridData: FlGridData(
                   show: true,
                   getDrawingHorizontalLine: (value){
                   return FlLine(
                   color: const Color(0xFFBDBDBD),
                   strokeWidth: 1,
                   );
                   },

                   drawVerticalLine: true,
                   getDrawingVerticalLine: (value){
                   return FlLine(
                   color: const Color(0xFFBDBDBD),
                   strokeWidth: 1,
                   );
                   },
                ),

                borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xFFBDBDBD), width: 1,),

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
                  barWidth: 5,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
                    ),
                  )
                ]
              ), 
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
  getTitles: (value){
    
      if(dayformat == "Friday"){
       switch (value.toInt()){
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
      }else{
        if(dayformat == "Saturday"){
       switch (value.toInt()){
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
        }else{
          if(dayformat == "Sunday"){
       switch (value.toInt()){
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
          }else{
            if(dayformat == "Monday"){
       switch (value.toInt()){
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
            }else{
                if(dayformat == "Tuesday"){
       switch (value.toInt()){
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
                }else{
                  if(dayformat == "Wednesday"){
       switch (value.toInt()){
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
                  }else{
                    if(dayformat == "Thursday"){
       switch (value.toInt()){
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
    fontSize: 16,
  ),
    // ignore: missing_return
   getTitles: (value){
   switch (value.toInt()){
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
     return "Puntuacion";     
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
   getTitles: (value){
   switch (value.toInt()){
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
   }

  return '';
  },
  reservedSize: 80,
  )
 );
}