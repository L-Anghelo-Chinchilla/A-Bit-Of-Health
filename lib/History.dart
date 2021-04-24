import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History
  ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:getAppBar(context),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('fondo_historial.jpg'),
              fit: BoxFit.cover
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            getDirectionsBar(context),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}