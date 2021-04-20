import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'routes.dart'; 
import 'providers/UserProvider.dart' ;

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: getRoutes() ,
    //  home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    
  
    setState(() async{
      UserProvider provider = UserProvider();
      UserModel user = await provider.getUserData('-wqweqwewqeqwewq');
      print(user.toJson());
      
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      Navigator.pushNamed(context, 'FoodSelector', arguments:user);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('HomePage'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           // Text(
            //  's many times:',
            //),
           // Text(
            //  '$_counter',
            //  style: Theme.of(context).textTheme.headline4,
           // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
