import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:provider/provider.dart';
import 'routes.dart';

void main()  {
 
WidgetsFlutterBinding.ensureInitialized();
 Firebase.initializeApp().then((value) => print('created'));
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
      
    
              child: MaterialApp(
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
  
    ),
      );
}
}
