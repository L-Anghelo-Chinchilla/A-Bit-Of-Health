import 'package:a_bit_of_health/Today.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'Login.dart';
import 'models/UserModel.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tuple2<String, String> range = ModalRoute.of(context).settings.arguments;
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else
      return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('fondo_historial.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'History'),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Registros desde ${range.item1} hasta ${range.item2}',
                      style: TextStyle(fontFamily: 'Mont2', fontSize: 20)),
                  Expanded(
                      child: Container(
                    color: Colors.white.withOpacity(0.8),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: FutureBuilder(
                        future: FoodProvider.getUserRegisterRange(
                            Provider.of<UserModel>(context, listen: false)
                                .userID,
                            '',
                            ''),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemBuilder: (context, i) {
                                return getRegisterList(
                                    context, FoodRegister(), false);
                              },
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('Atras'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Descargar'))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      );
  }
}
