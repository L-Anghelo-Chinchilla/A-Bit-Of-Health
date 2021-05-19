import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/authentification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';

Widget getDirectionsBar(BuildContext context, String name) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: Color(0xFF74BFBF),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (name == '/')
                ? Tab(
                    icon: Icon(Icons.home, color: Colors.white), text: 'Inicio')
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Tab(
                        icon: Icon(
                          Icons.home,
                        ),
                        text: 'Inicio')),
            (name == 'FoodSelector' ||
                    name == 'FoodCounter' ||
                    name == 'Evaluation')
                ? Tab(
                    icon: Icon(Icons.fastfood_outlined, color: Colors.white),
                    text: 'Comida')
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'FoodSelector');
                      Provider.of<List<FoodOffer>>(context, listen: false)
                          .clear();
                    },
                    child: const Tab(
                        icon: Icon(
                          Icons.fastfood_outlined,
                        ),
                        text: 'Comida')),
            (name == 'GlassesOfWater')
                ? Tab(
                    icon: Icon(Icons.invert_colors, color: Colors.white),
                    text: 'Agua')
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'GlassesOfWater');
                    },
                    child: const Tab(
                        icon: Icon(
                          Icons.invert_colors,
                        ),
                        text: 'Agua')),
            (name == 'Today')
                ? Tab(icon: Icon(Icons.star, color: Colors.white), text: 'Hoy')
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'Today');
                    },
                    child: const Tab(
                        icon: Icon(
                          Icons.star,
                        ),
                        text: 'Hoy')),
          ]));
}

Widget getAppBar({BuildContext context, String route}) {
  return AppBar(
    leading: (route == '')
        ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            })
        : Container(
            height: 1,
            width: 1,
          ),
    title: Padding(
      padding: const EdgeInsets.all(1.0),
      child: Image.asset('assets/LL.png', height: 55.0),
    ),
    backgroundColor: Color(0xff173749),
    brightness: Brightness.dark,
    actions: [
      if (route == null)
       
        if (Provider.of<UserModel>(context, listen: false).name != null)
          Padding(
              child: TextButton.icon(
                  onPressed: () async {
                    await AuthProvider.signOut();
                    Provider.of<UserModel>(context, listen: false).delete();
                    await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()),
                        ModalRoute.withName('/'));
                  },
                  icon: Icon(Icons.person),
                  label: Text('''Cerrar sesión
${Provider.of<UserModel>(context, listen: false).name}''')),
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10))
        else
          Padding(
              child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Login');
                  },
                  icon: Icon(Icons.person),
                  label: Text('Iniciar sesión')),
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10))
    ],
  );
}
