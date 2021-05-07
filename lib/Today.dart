import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  const Today({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('fondo_inicio.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'Today'),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ScoreView(
                          title: 'Calorías de día',
                          score: '457',
                        ),
                        ScoreView(
                          title: 'Puntuación de día',
                          score: '${3.5}',
                        ),
                      ],
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                      ),
                      child: Scrollbar(
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: 40,
                          itemBuilder: (context, i) {
                            return Register();
                          },
                        ),
                      ),
                    ))
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}

class Register extends StatelessWidget {
  
  const Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('comida'),
                  Text('Hora'),
                  IconButton(
                      icon: Icon(Icons.confirmation_num), onPressed: () {})
                ])),
         
         Container(
           height: 250,
           width:   500,
           child: ListView.builder(
             padding:  EdgeInsets.all(20),
            itemBuilder: (context , i ){
              return Row (
                //crossAxisAlignment: CrossAxisAlignment.star
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children:[

                  Text('Comida'),
                  Text('Porción'),
                  Text('Calorias'),

                ]
              );
            },

        ),
         ),

        Row(
          children: [
            Container(
               margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                ),
                padding: EdgeInsets.all(10),
                child: Text('Calorias: 456')),
            SizedBox(
              width: 10,
            ),
            Container(
               margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                ),
                padding: EdgeInsets.all(10),
                child: Text('Puntuación: 4.6'))
          ],
        )
      ],
    );
  }
}

class ScoreView extends StatelessWidget {
  const ScoreView({Key key, this.score, this.title}) : super(key: key);

  final String title;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            color: Colors.amber,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Center(child: Text(score)),
        ),
        Text(title)
      ],
    );
  }
}
