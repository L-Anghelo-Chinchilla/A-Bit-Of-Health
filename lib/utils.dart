import 'package:flutter/material.dart';

Widget getDirectionsBar(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.zero,
      color: Colors.limeAccent[700],
    ),
    child: Row (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
      GestureDetector(onTap:(){Navigator.pushNamed(context,'/');},child: const Tab(icon: Icon(Icons.home), text: 'Inicio')),
      GestureDetector(onTap:(){Navigator.pushNamed(context,'FoodSelector');},child:const Tab(icon: Icon(Icons.fastfood_outlined),text: 'Comida')),
      GestureDetector(onTap:(){Navigator.pushNamed(context,'Stats');},child:const Tab(icon: Icon(Icons.analytics), text: 'Estadísticas')),
      GestureDetector(onTap:(){Navigator.pushNamed(context,'GlassesOfWater');},child:const Tab(icon: Icon(Icons.invert_colors), text: 'Agua')),
      GestureDetector(onTap:(){Navigator.pushNamed(context,'History');},child:const Tab(icon: Icon(Icons.star), text: 'Historial')),
    ]
        )
    );
} 

Widget getAppBar(BuildContext context ){
 return AppBar(
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
          
    
    ); 




}


