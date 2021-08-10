import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/authentification.dart';


String theId;

class HomePage extends StatefulWidget {
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
              if (future.data) {
                return Home();
              } else
                return Home();
            } else {
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 250,
                width: 250,
              ));
            }
          });
    else {
      theId = Provider.of<UserModel>(context, listen: false).userID;

      theUpdate1();
      print(
          'Lo que debería ser la lista de cal es: ${Provider.of<UserModel>(context, listen: false).dailyCalories}');
      //theUpdate2();
      //theUpdate3();
      return Home();
    }
  }
}

Future<void> theUpdate1() async {
  await UserProvider().updateDailyCalories(theId);
}

Future<void> theUpdate2() async {
  await UserProvider().updateDailyGlasses(theId);
}

Future<void> theUpdate3() async {
  await UserProvider().updateDailyScore(theId);
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 2), () => "2");
}

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final List<String> phraseList = [
    '"NO NECESITAS COMER MENOS, NECESITAS COMER BIEN"',
    '"COMER ES UNA NECESIDAD, PERO COMER DE FORMA INTELIGENTE ES UN ARTE”',
    '“QUE TU MEDICINA SEA TU ALIMENTO, Y EL ALIMENTO TU MEDICINA”',
    '“CUIDA TU CUERPO. ES EL ÚNICO LUGAR QUE TIENES PARA VIVIR”',
    '"LA COMIDA QUE INGIERES PUEDE SER LA MÁS SEGURA Y PODEROSA FORMA DE MEDICINA O LA FORMA MÁS LENTA DE VENENO"',
    '"UN EXTERIOR SALUDABLE, INICIA DESDE EL INTERIOR"',
    '"NO HAY TRUCOS, ATAJOS, PASTILLAS MÁGICAS, POCIONES ESPECIALES O EQUIPO ESPECIAL. LO ÚNICO QUE NECESITAS ES DESEO Y VOLUNTAD"',
    '"CADA VEZ QUE COMES, ES UNA OPORTUNIDAD DE NUTRIR A TU CUERPO"',
    '“LA NUTRICIÓN ÓPTIMA ES LA MEDICINA DEL MAÑANA”',
    '“UNA MANZANA AL DÍA MANTIENE AL DOCTOR ALEJADO”',
    '“LA FORMA MÁS ECONÓMICA DE CONSEGUIR UNA BUENA SALUD ES CUIDANDO LA NUTRICIÓN”',
    '“UNA ALIMENTACIÓN SALUDABLE ES UNA SALUD DURADERA”'
  ];
  Random random = new Random();

  openURLfb() async {
    if (await canLaunch(
        "https://www.facebook.com/A-Bit-of-Health-101743945433320")) {
      await launch("https://www.facebook.com/A-Bit-of-Health-101743945433320");
    } else {
      throw 'No se encuentra pagina';
    }
  }

  openURLex() async {
    if (await canLaunch("http://gymvirtual.com/")) {
      await launch("http://gymvirtual.com/");
    } else {
      throw 'No se encuentra pagina';
    }
  }

  openURLfo() async {
    if (await canLaunch("https://www.lacocinasana.com/")) {
      await launch("https://www.lacocinasana.com/");
    } else {
      throw 'No se encuentra pagina';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1517260911058-0fcfd733702f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2560&q=80'),
                  fit: BoxFit.cover),
            ),
            child: Column(
                //mainAxisAlignment:  MainAxisAlignment.center,

                children: [
                  getDirectionsBar(context, '/'),
                  Expanded(
                    child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          Container(
                            padding: EdgeInsets.all(40),
                            color: Color(0xFFD0E3DA).withOpacity(0.7),
                            width: (MediaQuery.of(context).size.width) / 2.7,
                            child: (Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  //'OUR FOOD SHOULD BE OUR MEDICINE & OUR MEDICINE SHOULD BE OUR FOOD',
                                  phraseList.elementAt(random.nextInt(12)),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Mont'),
                                ),
                                Text(
                                  'A Bit of Health es tu nuevo compañero, el cual te ayudará a centrarte en un estilo de vida y elecciones de dieta saludables. Es la mejor app para alguien que comienza con un control de comida y agua, quiere perder peso o quiere ser consciente.',
                                  style: TextStyle(
                                      fontSize: 19, fontFamily: 'Mont3'),
                                ),
                              ],
                            )),
                          ),
                          Container(
                            padding: EdgeInsets.all(40),
                            width: (MediaQuery.of(context).size.width) / 1.9,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  color: Colors.yellow,
                                  height: (MediaQuery.of(context).size.height) /
                                      1.8,
                                  width: (MediaQuery.of(context).size.width) /
                                      2.2, //500
                                  child: ListView(children: [
                                    SizedBox(
                                      height:
                                          (MediaQuery.of(context).size.height) /
                                              1.8,
                                      width:
                                          (MediaQuery.of(context).size.width) /
                                              2.2,
                                      child: Carousel(
                                        images: [
                                          Image.asset(
                                            'assets/carrusel01.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/carrusel02.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/carrusel03.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/carrusel04.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/carrusel05.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                          Image.asset(
                                            'assets/carrusel06.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                        boxFit: BoxFit.cover,
                                        autoplay: true,
                                        autoplayDuration:
                                            Duration(milliseconds: 10000),
                                        animationCurve: Curves.fastOutSlowIn,
                                        animationDuration:
                                            Duration(milliseconds: 1000),
                                        dotSize: 12.0,
                                        dotIncreasedColor: Color(0xff173749),
                                        dotBgColor: Colors.transparent,
                                        dotPosition: DotPosition.bottomCenter,
                                        dotVerticalPadding: 10.0,
                                        showIndicator: true,
                                        indicatorBgPadding: 7.0,
                                      ),
                                    ),
                                  ]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        //width: (MediaQuery.of(context).size.width)/18,
                                        //height: (MediaQuery.of(context).size.width)/40,
                                        /*decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/1.jpg'),
                                        ),
                                      ),*/
                                        child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: Color(0xFF64BEC3),
                                            padding: EdgeInsets.all(0.0),
                                            //textTheme: ButtonTextTheme,
                                            onPressed: () {
                                              openURLfo();
                                            },
                                            child: Text('Recetas',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)))),
                                    Container(
                                        //width: (MediaQuery.of(context).size.width)/18,
                                        //height: (MediaQuery.of(context).size.width)/40,
                                        /*decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/2.jpg'),
                                        ),
                                      ),*/
                                        child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: Color(0xFF64BEC3),
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {
                                        openURLex();
                                      },
                                      child: Text('Ejercicios',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        '¿Necesitas soporte?  Contáctanos:     ',
                                        style: TextStyle(
                                            fontFamily: 'Pt',
                                            fontSize: 18,
                                            backgroundColor: Color(0xFFD0E3DA)
                                                .withOpacity(0.8)),
                                      ),
                                    ),
                                    Container(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) /
                                            40,
                                        height: (MediaQuery.of(context)
                                                .size
                                                .width) /
                                            40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/facebook.png'),
                                          ),
                                        ),
                                        child: FlatButton(
                                            padding: EdgeInsets.all(0.0),
                                            onPressed: () {
                                              openURLfb();
                                            },
                                            child: null))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ])),
                  ),
                ])));
  }
}
