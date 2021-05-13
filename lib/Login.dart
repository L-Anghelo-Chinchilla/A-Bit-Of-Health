import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _hide = true ;
  final _email  = TextEditingController(),
  _pass = TextEditingController();
  void Function() change(){
    setState(() {
      _hide = !_hide;
    });
    
  }



  @override
  Widget build(BuildContext context) {
    _email.text = '';
    return Scaffold(
      appBar: getAppBar(context:context , route: ''),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
          SizedBox(
            height: 700,
            width: 700,
                    child: Card(
              margin: EdgeInsets.all(100),
              elevation: 10,
            child: Padding(padding: EdgeInsets.all(15),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Inicio de sesión', style: TextStyle(fontSize: 30, ),),
                getTextForm(_email ,'Correo electrónico' , false),
                getTextForm(_pass,'Contraseña' , _hide),
                ElevatedButton(onPressed: (){
                  Provider.of<UserModel>(context , listen: false).setUser(UserModel(userID:'-wqweqwewqeqwewq' ,name: 'Pedro Perez' ));
                  
                  Navigator.pushReplacementNamed(context, '/');

                },
                child: Text('Iniciar sesión'),)
              ],
            )), 
            ),
          )
     ),
      )
    );
  }

  Widget getTextForm(controller ,hint , hide ){
    bool flag = hint == 'Contraseña';
    
    return  TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        icon: (flag)? Icon(Icons.lock) : Icon(Icons.person_pin_rounded) , 
        labelText: hint,
        suffixIcon: (flag)? 
        IconButton(onPressed: change,
         icon:(hide)?Icon(Icons.remove_red_eye_outlined):Icon(Icons.remove_red_eye),
         ):Container(height:1, width: 1,),
      ),
      controller: controller, 
      obscureText:hide ,
      maxLength: 50,
    );


  }
}