
import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/authentification.dart';
import 'package:flutter/material.dart';

import 'package:a_bit_of_health/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     if (Provider.of<UserModel>(context, listen: false).userID == null)
      return FutureBuilder<bool>(
          future: AuthProvider.getUser(context),
          builder: (context, AsyncSnapshot<bool> future) {
            if (future.hasData) {
              if (future.data)
                return Home();
              else
                return Login();
            } else {
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 250,
                width: 250,
              ));
            }
          });
    else
      return Home(); 
  }
}


class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context:context),
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
