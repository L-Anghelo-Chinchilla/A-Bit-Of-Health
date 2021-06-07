import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stat_Score extends StatelessWidget {
  const Stat_Score({Key key}) : super(key: key);

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
                      alignment: Alignment.center,
                      child: Column(),
                    ),
                  ),
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
                ]),
          ));
    }
  }
}
