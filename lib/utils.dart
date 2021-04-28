import 'package:flutter/material.dart';

Widget getDirectionsBar(BuildContext context, String name ){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.zero,
      color: Color(0xFF74BFBF),
    ),
    child: Row (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
     /* (name == '/') ?
          Tab(icon: Icon(Icons.home, color: Colors.white), text: 'Inicio')
      :
      GestureDetector(onTap:(){Navigator.pushNamed(context,'/');},child: const Tab(icon: Icon(Icons.home,), text: 'Inicio')),*/
      (name == 'FoodSelector'  || name == 'FoodCounter') ?Tab(icon: Icon(Icons.fastfood_outlined, color: Colors.white),text: 'Comida')
      :
      GestureDetector(onTap:(){Navigator.pushReplacementNamed(context,'FoodSelector');},child:const Tab(icon: Icon(Icons.fastfood_outlined,),text: 'Comida')),
    /*  (name == 'Stats') ?Tab(icon: Icon(Icons.analytics,color: Colors.white), text: 'Estadísticas')
      :
      GestureDetector(onTap:(){Navigator.pushNamed(context,'Stats');},child:const Tab(icon: Icon(Icons.analytics,), text: 'Estadísticas')),*/
      (name == 'GlassesOfWater') ?Tab(icon: Icon(Icons.invert_colors,color: Colors.white), text: 'Agua')
      :
      GestureDetector(onTap:(){Navigator.pushReplacementNamed(context,'GlassesOfWater');},child:const Tab(icon: Icon(Icons.invert_colors,), text: 'Agua')),
    /*  (name == 'History') ?Tab(icon: Icon(Icons.star,color: Colors.white), text: 'Historial')
      :
      GestureDetector(onTap:(){Navigator.pushNamed(context,'History');},child:const Tab(icon: Icon(Icons.star,), text: 'Historial')),*/
    ]
        )
    );
} 

Widget getAppBar(BuildContext context ){
 return AppBar(
            leading: Container(height: 1 ,width: 1,),
            title: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Image.asset('assets/Head.png', height: 90.0),
          ),
          backgroundColor: Color(0xff173749),
          brightness: Brightness.dark,
         /* actions: [
            Image(
              image: AssetImage('assets/usuario.png'),
              fit: BoxFit.contain,
              height: 60,
            )
          ],*/
          
    
    ); 




}


