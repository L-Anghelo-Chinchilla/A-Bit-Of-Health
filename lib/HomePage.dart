import 'package:a_bit_of_health/FoodCounter.dart';
import 'package:a_bit_of_health/GlassesOfWater.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:a_bit_of_health/FoodSelector.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage
  ({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {

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
              color: Colors.blue,
              width: (MediaQuery.of(context).size.width)/2.7,

              child: (
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Our food should be our medicine & our medicine should be our food',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'A Bit of Health es tu nuevo compañero, el cual te ayudará a centrarte en un estilo de vida y elecciones de dieta saludables. Es la mejor app para alguien que comienza con un control de comida y agua, quiere perder peso o quiere ser consciente.'
                    ),
                  ],
                )
              ),
            ),
          Container(
            padding: EdgeInsets.all(40),
            color: Colors.green,
            width: (MediaQuery.of(context).size.width)/1.9,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                          Container(
                                width: (MediaQuery.of(context).size.width)/35,
                                height: (MediaQuery.of(context).size.width)/35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/1.jpg'),
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
                  height: (MediaQuery.of(context).size.height)/2,
                  width: (MediaQuery.of(context).size.width)/2.5,//500 
                  child: ListView(
                    children: [
                      SizedBox(
                        height: (MediaQuery.of(context).size.height)/2,
                        width: (MediaQuery.of(context).size.width)/2.5,
                        child: Carousel(
                          images: [
                            Image.asset('assets/1.jpg', fit: BoxFit.cover,),
                            Image.asset('assets/2.jpg', fit: BoxFit.cover,),
                            Image.asset('assets/3.jpg', fit: BoxFit.cover,),
                          ],
                          boxFit: BoxFit.cover,
                          autoplay: true,
                          autoplayDuration: Duration(milliseconds: 10000),
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotSize: 12.0,
                          dotIncreasedColor: Colors.lime,
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
                                      width: (MediaQuery.of(context).size.width)/35,
                                      height: (MediaQuery.of(context).size.width)/35,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/1.jpg'),
                                        ),
                                      ),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {
                                          openURLfo();
                                        }, 
                                        child: null)
                              ),
                             Container(
                                      width: (MediaQuery.of(context).size.width)/35,
                                      height: (MediaQuery.of(context).size.width)/35,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/2.jpg'),
                                        ),
                                      ),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {
                                          openURLex();
                                        }, 
                                     child: null)
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