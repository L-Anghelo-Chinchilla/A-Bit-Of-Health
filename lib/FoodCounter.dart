import 'package:flutter/material.dart';

class FoodCounter extends StatelessWidget {
  const FoodCounter({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _TabPages = <Widget>[
      const Center(child: Icon(Icons.home)),
      const Center(child: Icon(Icons.analytics)),
      const Center(child: Icon(Icons.calendar_today_rounded)),
      const Center(child: Icon(Icons.star)),
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
