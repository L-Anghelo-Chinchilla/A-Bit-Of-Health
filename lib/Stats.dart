import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stats extends StatelessWidget {
  const Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     if(Provider.of<UserModel>(context).userID ==null)
      return Login();
    else
         return Scaffold(
      appBar: getAppBar(context:context),
      body: Container(
                decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('fondo_Stats.jpg'),
              fit: BoxFit.cover
            ),
          ),
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            getDirectionsBar(context , 'Stats'),
            Expanded(child: Container())



          ],

        ),
      ),
        );
  }
}