import 'package:a_bit_of_health/FoodCounter.dart';
import 'package:a_bit_of_health/GlassesOfWater.dart';
import 'package:flutter/material.dart';
import 'package:a_bit_of_health/FoodSelector.dart';

class HomePage extends StatelessWidget {
  const HomePage
  ({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {

   // UserModel user = ModalRoute.of(context).settings.arguments;
    //String _formatdate = new DateFormat.yMMMd().format(_currentDate);
    final _TabPages = [
      Center(child: Icon(Icons.home)),
      FoodSelector(),
      //Center(child: Icon(Icons.analytics)),
      FoodCounter(),
      GlassesOfWater(),
      Center(child: Icon(Icons.file_present)),

      //GlassesOfWater1(user: ModalRoute.of(context).settings.arguments,)
      //const Center(child: Icon(Icons.star)),
      //const Center(child: Text("Date: $_currentDate")),
    ];
    final _KTabs = <Tab>[
      const Tab(icon: Icon(Icons.home), text: 'Inicio'),
      const Tab(icon: Icon(Icons.fastfood_outlined),text: 'Comida'),
      const Tab(icon: Icon(Icons.analytics), text: 'Estadísticas'),
      const Tab(icon: Icon(Icons.invert_colors), text: 'Agua'),
      const Tab(icon: Icon(Icons.star), text: 'Historial'),
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
          physics: NeverScrollableScrollPhysics(),
          children: _TabPages,
        ),
      ),
    );
  }
}