import 'package:flutter/material.dart';
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
      GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
                    Card(
                      
                     elevation: 5,
                       child: Container(
                        //Alignment.centerLeft es Alignment(-1.0, 0.0),
                        child: Image.asset('assets/panes.png',width:200)
                     )
                   ),
                     Card(
                     elevation: 5,
                       child: Container(
                        child: Image.asset('assets/acompañantes.jpg',width:200)
               )
            ),
             Card(
                     elevation: 5,
                       child: Container(
                        child: Image.asset('assets/bebidaCal.jfif',width:200)
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
