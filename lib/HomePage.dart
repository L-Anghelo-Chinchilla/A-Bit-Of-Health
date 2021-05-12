import 'package:a_bit_of_health/FoodCounter.dart';
import 'package:a_bit_of_health/GlassesOfWater.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:a_bit_of_health/FoodSelector.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';


class HomePage extends StatelessWidget {
  const HomePage
  ({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {

List<String> phraseList = ["DEJEN QUE LOS ALIMENTOS SEAN SU MEDICINA Y QUE LA MEDICINA SEA SU ALIMENTO","NO NECESITAS COMER MENOS, NECESITAS COMER BIEN","COMER ES UNA NECESIDAD, PERO COMER DE FORMA INTELIGENTE ES UN ARTE"];
  Random random = new Random();

  openURLfb() async {
        if (await canLaunch ("https://www.facebook.com/A-Bit-of-Health-101743945433320")){
            await launch("https://www.facebook.com/A-Bit-of-Health-101743945433320");
        }else{
            throw 'No se encuentra pagina';
        }
  }

  openURLex() async {
        if (await canLaunch ("http://gymvirtual.com/")){
            await launch("http://gymvirtual.com/");
        }else{
            throw 'No se encuentra pagina';
        }
  }

  openURLfo() async {
        if (await canLaunch ("https://www.lacocinasana.com/")){
            await launch("https://www.lacocinasana.com/");
        }else{
            throw 'No se encuentra pagina';
        }
  }

    return 
       Scaffold(
        appBar: getAppBar(context), 
    body: Container(
      decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('fondo_home.jpg'),
              fit: BoxFit.cover
            ),
          ),
      child: Column(    
        //mainAxisAlignment:  MainAxisAlignment.center,
        
        children: [

          getDirectionsBar(context, '/'), 
          Expanded(child: Container(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Container(
              padding: EdgeInsets.all(40),
              color: Color(0xFFD0E3DA).withOpacity(0.7),
              width: (MediaQuery.of(context).size.width)/2.7,

              child: (
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      phraseList.elementAt(random.nextInt(3)),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 35, fontFamily: 'Mont'),
                    ),
                    Text(
                      'A Bit of Health es tu nuevo compañero, el cual te ayudará a centrarte en un estilo de vida y elecciones de dieta saludables. Es la mejor app para alguien que comienza con un control de comida y agua, quiere perder peso o quiere ser consciente.',
                      style: TextStyle(fontSize: 19, fontFamily: 'Mont3'),
                    ),
                  ],
                )
              ),
            ),
          Container(
            padding: EdgeInsets.all(40),
            width: (MediaQuery.of(context).size.width)/1.9,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                          Container(
                                width: (MediaQuery.of(context).size.width)/45,
                                height: (MediaQuery.of(context).size.width)/45,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/fac.jpg'),
                                  ),
                                ),
                                child: FlatButton(
                                  padding: EdgeInsets.all(0.0),
                                  onPressed: () {
                                    openURLfb();
                                  }, 
                                  child: null)
                          ),
                     ],
                ),
                Container(
                  color: Colors.yellow,
                  height: (MediaQuery.of(context).size.height)/1.8,
                  width: (MediaQuery.of(context).size.width)/2.2,//500 
                  child: ListView(
                    children: [
                      SizedBox(
                        height: (MediaQuery.of(context).size.height)/1.8,
                        width: (MediaQuery.of(context).size.width)/2.2,
                        child: Carousel(
                          images: [
                            Image.asset('assets/carrusel01.jpg', fit: BoxFit.cover,),
                            Image.asset('assets/carrusel02.jpg', fit: BoxFit.cover,),
                            Image.asset('assets/carrusel03.jpg', fit: BoxFit.cover,),
                            Image.asset('assets/carrusel04.jpg', fit: BoxFit.cover,),
                          ],
                          boxFit: BoxFit.cover,
                          autoplay: true,
                          autoplayDuration: Duration(milliseconds: 10000),
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotSize: 12.0,
                          dotIncreasedColor: Color(0xff173749),
                          dotBgColor: Colors.transparent,
                          dotPosition: DotPosition.bottomCenter,
                          dotVerticalPadding: 10.0,
                          showIndicator: true,
                          indicatorBgPadding: 7.0,
                    
                        ),
                      ),
                    ]
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                            Container(
                                      width: (MediaQuery.of(context).size.width)/18,
                                      height: (MediaQuery.of(context).size.width)/40,
                                      /*decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/1.jpg'),
                                        ),
                                      ),*/
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        color: Color(0xFF64BEC3),
                                        padding: EdgeInsets.all(0.0),
                                        //textTheme: ButtonTextTheme,
                                        onPressed: () {
                                          openURLfo();
                                        }, 
                                        child: Text('Recetas', style: TextStyle(color: Colors.white, fontSize: 16)))
                              ),
                             Container(
                                      width: (MediaQuery.of(context).size.width)/18,
                                      height: (MediaQuery.of(context).size.width)/40,
                                      /*decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/2.jpg'),
                                        ),
                                      ),*/
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        color: Color(0xFF64BEC3),
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {
                                          openURLex();
                                        }, 
                                     child: Text('Ejercicios', style: TextStyle(color: Colors.white, fontSize: 16)),)
                                ),
                            ],
                ),
              ],
            ),
          ),
        ]  
      )
          ),),

          


        ],



      ),
    ));
  }
}