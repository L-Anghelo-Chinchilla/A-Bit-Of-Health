import 'package:a_bit_of_health/Evaluation.dart';
import 'package:a_bit_of_health/History.dart';
import 'package:a_bit_of_health/HomePage.dart';
import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/Stats.dart';
import 'package:a_bit_of_health/Today.dart';
import 'package:a_bit_of_health/Stat_Glasses.dart';
import 'package:a_bit_of_health/Stat_Calories.dart';
import 'package:a_bit_of_health/Stat_Score.dart';
import 'package:a_bit_of_health/main.dart';
import 'package:flutter/material.dart';
import 'FoodCounter.dart';
import 'FoodSelector.dart';
import 'Stats.dart';
import 'Stat_Glasses.dart';
import 'GlassesOfWater.dart';

//Mapa de Rutas de la aplicación
//parametros(nombre de ruta , contructor)

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    'FoodSelector': (context) => FoodSelector(),
    'FoodCounter': (context) => FoodCounter(),
    'GlassesOfWater': (context) => GlassesOfWater(),
    'History': (context) => History(),
    'Stats': (context) => Stats(),
    'Evaluation': (context) => Evaluation(),
    'Login': (context) => Login(),
    'Today': (context) => Today(),
    'Stat_Glasses': (context) => Stat_Glasses(),
    'Stat_Calories': (context) => Stat_Calories(),
    'Stat_Score': (context) => Stat_Score(),
  };
}
