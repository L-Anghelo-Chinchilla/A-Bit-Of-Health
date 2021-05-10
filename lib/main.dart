import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';

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
    Provider.debugCheckInvalidValueType = null;
    return

    MultiProvider(
      providers: 
      [
        Provider(create:(_) => UserModel()),
        Provider(create:(_) => FoodOfferModel(foodOffers:[])),
        ChangeNotifierProvider(create: (_) => Food()) 
      ],
      
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      
      theme: ThemeData(
        /*  scrollbarTheme: ScrollbarThemeData( crossAxisMargin: 15 , trackBorderColor:MaterialStateProperty.resolveWith( 
              (Set<MaterialState> state){
                if(state.any((e )=> e == MaterialState.hovered))
                return Color(0xFFF96969);
                else 
                return Color(0xFF961616);
              } 

          )),*/
           scrollbarTheme: ScrollbarThemeData().copyWith(
             trackBorderColor:  MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
             showTrackOnHover: true,
             isAlwaysShown:  true,
          thumbColor: MaterialStateProperty.all((Colors.white.withOpacity(0.5))),
          trackColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1))),
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'FoodSelector',
      routes: getRoutes(),
  
    ));
  }
}
