import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/Stat_Calories.dart';
import 'package:a_bit_of_health/Stat_Glasses.dart';
import 'package:a_bit_of_health/Stat_Score.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stats extends StatelessWidget {
  const Stats({Key key}) : super(key: key);

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
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1615224572756-729e7d1cd942?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2560&q=80'),
                  fit: BoxFit.cover),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getDirectionsBar(context, 'Stats'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text(
                      'Seleccionar el tipo de Estadísticas',
                      style: TextStyle(fontFamily: 'Mont', fontSize: 32.0),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 30),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.7),
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.5,
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
                                    height: 70,
                                    minWidth: 150,
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      List<dynamic> theglass =
                                          await UserProvider().getGforStats(
                                              Provider.of<UserModel>(context,
                                                      listen: false)
                                                  .userID);
                                      Navigator.of(context).push(
                                          MaterialPageRoute<Null>(
                                              builder: (context) =>
                                                  StatGlasses(
                                                    list: theglass,
                                                  )));
                                      /*Navigator.pushNamed(
                                            context, 'Stat_Glasses');*/
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
                                    height: 70,
                                    minWidth: 150,
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      List<dynamic> thescore =
                                          await UserProvider().getSforStats(
                                              Provider.of<UserModel>(context,
                                                      listen: false)
                                                  .userID);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute<Null>(
                                              builder: (context) => StatScore(
                                                    list: thescore,
                                                  )));
                                      //Navigator.pushNamed(context, 'Stat_Score');
                                    })
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImagestoDisplay(imageName: "kcalEST"),
                                MaterialButton(
                                    child: Text(
                                      'Calorías',
                                      style: new TextStyle(fontSize: 22),
                                    ),
                                    height: 70,
                                    minWidth: 150,
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      List<dynamic> thecals =
                                          await UserProvider().getCforStats(
                                              Provider.of<UserModel>(context,
                                                      listen: false)
                                                  .userID);
                                      Navigator.of(context).push(
                                          MaterialPageRoute<Null>(
                                              builder: (context) =>
                                                  StatCalories(
                                                    list: thecals,
                                                  )));
                                      /*Navigator.pushNamed(
                                            context, 'Stat_Calories');*/
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ));
  }
}

// ignore: must_be_immutable
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

// ignore: must_be_immutable
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
