import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'providers/UserProvider.dart';

void main() {
  //final provider = FoodProvider();
  //print('{"Almuerzo":[{"lista":["Ensalada"],"tipo":"Aperitivos"},{"lista":["Refresco de Canela","Refresco de Durazno","Refresco de Mocochinchi"],"tipo":"Refrescos"}],"Cena":[{"lista":["Té","Mate"],"tipo":"calientes"}],"Desayuno":[{"Alimentos":["Huevos","Queso","Mermelada","Mantequilla","Aceitunas","Tocino","Jamón","Queso crema","Miel"],"tipo":"Acompañantes"},{"alimetos":["Café","Te negro","Te verde","Avena","Leche","Chocolate","Api","Tojori"],"tipo":"Calientes"},{"alimentos":["Jugo verde","Jugo de naranja","Jugo de limón","Jugo de frutilla","Yogourt"],"tipo":"Frios"},{"alimentos":["Torta","Dona","Salteña","Tucumana","Relleno de papa","Relleno de achojcha","Pasteles de queso"],"tipo":"Otro"},{"alimentos":["Pan blanco","Pan integral","Waffles","Hotcakes"],"tipo":"Panes"}],"Snack":[{"lista":["COCA-COLA","Refresco de Canela","Refresco de Durazno","Refresco de Mocochinchi"],"tipo":"refresco"}]}');

  //  provider.setUserWaterLimit('-asdasdaadasdasada', 10);
  // provider.setUserWaterLimit('-wqweqwewqeqwewq',11);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: getRoutes(),
  
    );
  }
}
