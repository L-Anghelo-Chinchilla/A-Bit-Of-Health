import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          getDirectionsBar(context),
          Expanded(child: Container())



        ],

      ),
        );
  }
}