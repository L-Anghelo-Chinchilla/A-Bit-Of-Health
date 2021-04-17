import 'package:a_bit_of_health/main.dart';
import 'package:flutter/material.dart';
import 'FoodCounter.dart';
import 'FoodSelector.dart';
import 'GlassesOfWater.dart';


//Mapa de Rutas de la aplicación 
//parametros(nombre de ruta , contructor)


Map<String, WidgetBuilder> getRoutes(){

 return <String , WidgetBuilder>{
    '/':(context ) => MyHomePage(),
    'FoodSelector': (context) => FoodSelector(),
    'FoodCounter': (context) => FoodCounter(),
   'GlassesOfWater' : (context) => GlassesOfWater()
 };


}