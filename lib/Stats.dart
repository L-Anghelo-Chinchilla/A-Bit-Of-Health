import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/authentification.dart';



class Stats extends StatefulWidget {
  Stats({Key key}) : super(key: key);

  @override
  _CaloriesState createState() => _CaloriesState();
}

class _CaloriesState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserModel>(context, listen: false).userID);
    if (Provider.of<UserModel>(context, listen: false).userID == null)
      return FutureBuilder<bool>(
          future: AuthProvider.getUser(context),
          builder: (context, AsyncSnapshot<bool> future) {
            if (future.hasData) {
              if (future.data)
                return StatsPage();
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
      return StatsPage();
  }
}



class StatsPage extends StatelessWidget {
  const StatsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else
      return Scaffold(
          appBar: getAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('fondo_est.jpg'), fit: BoxFit.cover),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getDirectionsBar(context, 'Stats'),
                  Text(
                    'Seleccionar el tipo de Estadísticas',
                    style: TextStyle(fontFamily: 'Mont', fontSize: 32.0),
                  ),
                  Expanded(
                    child: Container(
                        
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImagestoDisplay(imageName: "aguaEST"),
                              MaterialButton(
                                  child: Text('Vasos de Agua',
                                      style: new TextStyle(fontSize: 22)),
                                  height: 80,
                                  minWidth: 150,
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'Stat_Glasses');
                                  })
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImagestoDisplay(imageName: "estrellasEST"),
                              MaterialButton(
                                  child: Text('Puntuación',
                                      style: new TextStyle(fontSize: 22)),
                                  height: 80,
                                  minWidth: 150,
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'Stat_Score');
                                  })
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImagestoDisplay(
                                  imageName: "kcalEST".toLowerCase()),
                              MaterialButton(
                                  child: Text(
                                    'Calorias',
                                    style: new TextStyle(fontSize: 22),
                                  ),
                                  height: 80,
                                  minWidth: 150,
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'Stat_Calories');
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ]),
          ));
  }
}

class ImagestoDisplay extends StatelessWidget {
  String imageName;

  ImagestoDisplay({this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Image.asset(
          'assets/$imageName.png',
          width: 250,
          height: 250,
        ));
  }
}

class TitleDisplay extends StatelessWidget {
  String titleName;

  TitleDisplay({this.titleName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFDC7633).withOpacity(0.8),
      width: 180.0, //MediaQuery.of(context).size.width * 0.1,
      height: 35.0, //MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Text(
        titleName,
        style: TextStyle(
          fontFamily: 'Mont2',
          fontSize: 20.0,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}