import 'dart:html';

import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

class GlassesOfWater extends StatelessWidget {
  UserProvider _provider = UserProvider();
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: getAppBar(context),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          getDirectionsBar(context),
          Expanded(
              child: Center(
                  child:
         FutureBuilder<UserModel>(
            future: _provider.getUserData(
                '-wqweqwewqeqwewq'), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.hasData) {
                return GlassesOfWater1(user: snapshot.data);
              } else {
                return Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ));
              }
            }) //

        // GlassesOfWater1(user: UserModel(weight: 85.3, height: 1.7, email: "sanchopanza@gmail.com", gender: "M", name: "Sancho Panza", waterLimit: 10, newWaterLimit: 8, waterLimitDate: "14/04/2021", glasses: 3) )//ModalRoute.of(context).settings.arguments )
        ))]));
  }
}

class GlassesOfWater1 extends StatefulWidget {
  GlassesOfWater1({Key key, this.user}) : super(key: key);
  UserModel user;

  @override
  _GlassesOfWatterState createState() => _GlassesOfWatterState();
}

class _GlassesOfWatterState extends State<GlassesOfWater1> {
  UserProvider provider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return
         Card(
                      child: Padding(
                          padding: EdgeInsets.all(29),
                          child: Column(
                            children: [
                              Text('Vasos de agua'),
                              Expanded(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      child: ListView.builder(
                                        itemCount: widget.user.waterLimit,
                                        padding: EdgeInsets.all(7),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          print(
                                              '$i  ${widget.user.waterLimit}');
                                          var state = (i < widget.user.glasses)
                                              ? 'lleno'
                                              : 'vacio';
                                          return Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  'lib/assets/vaso_$state.png',
                                                  width: 150,
                                                  height: 150,
                                                ),
                                                Text('${i + 1}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF3FBCF0))),
                                              ]);
                                        },
                                      ))),
                              SizedBox(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    child: Text('Quitar un vaso'),
                                    onPressed: () async {
                                      if (widget.user.glasses > 0) {
                                        widget.user.glasses--;
                                        provider.setUserWaterGlasses(
                                            widget.user.userID,
                                            widget.user.glasses);
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Ya no puedes quitar más vasos!, ¿o sí?'),
                                          action: SnackBarAction(
                                            label: 'No. no puedo',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                  ElevatedButton(
                                      child: Text('Llenar un vaso'),
                                      onPressed: () async {
                                        if (widget.user.glasses <
                                            widget.user.waterLimit) {
                                          widget.user.glasses++;
                                          await provider.setUserWaterGlasses(
                                              widget.user.userID,
                                              widget.user.glasses);
                                        } else {
                                          final snackBar = SnackBar(
                                            content: Text('''YEY! Felicidades!, 
completaste los vasos del día,
modifica tu límite de vasos diarios si lo deseas.'''),
                                            action: SnackBarAction(
                                              label: 'Gracias!',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                        setState(() {});
                                      })
                                ],
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text('Editar Límite'))
                            ],
                          )));
  }
}
