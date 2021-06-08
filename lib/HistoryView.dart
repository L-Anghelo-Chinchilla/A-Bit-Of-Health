
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login.dart';
import 'models/UserModel.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key key}) : super(key: key);

@override
  Widget build(BuildContext context) {
     if(Provider.of<UserModel>(context).userID ==null)
      return Login();
    else
         return Scaffold(
      appBar:getAppBar(context:context),
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
            getDirectionsBar(context , 'History'),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
              ],
            ))
          ],
        ),
      ),
    );
  }
}