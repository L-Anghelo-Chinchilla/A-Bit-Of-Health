import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:intl/intl.dart';

class FoodCounter extends StatelessWidget {
  const FoodCounter({Key key}) : super(key: key);

  //DateTime _currentDate = new DateTime.now();

  /*Future<Null> selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2021));
  }*/

  @override
  Widget build(BuildContext context) {
     //String _formatdate = new DateFormat.yMMMd().format(_currentDate);
    final _TabPages = <Widget>[
        ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
                    Center(

                        child: Text('Añadir Comidas')
                    ),
                    /*ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Card(
                          child:  Container(
                                  child: Image.asset('assets/bebidaCaliente.jpg',width:250),
                          )
                      )
                      ],
                    ),*/
                      Container(
                      height: 200,
                       child: Container(
                         //alignment: Alignment.topCenter,
                        child: Image.asset('assets/calientes.png',width:200),
                        
                      )
                    ),
                       Container(
                     height: 200,
                       child: Container(
                         //alignment: Alignment.topCenter,
                        child: Image.asset('assets/frios.png',width:200)
                    )
                   ),
                   Container(
                     height: 200,
                       child: Container(
                         //alignment: Alignment.topCenter,
                        child: Image.asset('assets/masas.png',width:200)
                    ) 
                   ),
                    Container(
                     height: 200,
                       child: Container(
                         //alignment: Alignment.topCenter,
                        child: Image.asset('assets/acompanantes.png',width:200)
                      )
                     )
                    
      
        ]
      ),
      Center(child: Icon(Icons.analytics)),
       Center(child: Icon(Icons.calendar_today_rounded)),
      const Center(child: Icon(Icons.star)),
      //const Center(child: Text("Date: $_currentDate")),
    ];
      final _KTabs = <Tab>[
      const Tab(icon: Icon(Icons.home), text: 'Inicio'),
      const Tab(icon: Icon(Icons.analytics), text: 'Estadísticas'),
      const Tab(icon: Icon(Icons.calendar_today_rounded), text: 'Calendario'),
      const Tab(icon: Icon(Icons.star), text: 'Hoy'),
    ];
    return DefaultTabController(
      length: _KTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('A Bit Of Health'),
          backgroundColor: Colors.limeAccent[700],
          brightness: Brightness.dark,
          actions: [
            Image(
              image: AssetImage('assets/ABitOfHealth.png'),
              fit: BoxFit.contain,
              height: 60,
            )
          ],
          bottom: TabBar(
            tabs: _KTabs,
          ),
        ),
        body: TabBarView(
          children: _TabPages,
        ),
      ),
    );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Text('Añadir comida'),
        ]
        )
    );
  }

