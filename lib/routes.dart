import 'package:a_bit_of_health/Evaluation.dart';
import 'package:a_bit_of_health/History.dart';
import 'package:a_bit_of_health/HomePage.dart';
import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/Stats.dart';
import 'package:a_bit_of_health/Today.dart';
import 'package:a_bit_of_health/main.dart';
import 'package:flutter/material.dart';
import 'FoodCounter.dart';
import 'FoodSelector.dart';
import 'GlassesOfWater.dart';
import 'HistoryView.dart';

//Mapa de Rutas de la aplicación
//parametros(nombre de ruta , contructor)

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    'FoodSelector': (context) => FoodSelector(),
    'FoodCounter': (context) => FoodCounter(),
    'GlassesOfWater': (context) => GlassesOfWater(),
    'History': (context) => History(),
    'HistoryView': (context) => HistoryView(),
    'Stats': (context) => Stats(),
    'Evaluation': (context) => Evaluation(),
    'Login': (context) => Login(),
    'Today': (context) => Today()
  };
}
