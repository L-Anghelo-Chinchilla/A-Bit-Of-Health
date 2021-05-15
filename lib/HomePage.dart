import 'package:a_bit_of_health/FoodCounter.dart';
import 'package:a_bit_of_health/GlassesOfWater.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:a_bit_of_health/FoodSelector.dart';
import 'package:a_bit_of_health/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              getDirectionsBar(context, '/'),
              Expanded(
                child: Container(),
              )
            ],
          ),
        ));
  }
}
