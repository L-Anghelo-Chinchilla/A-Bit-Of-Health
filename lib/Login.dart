import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/authentification.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _hide = true;
  final _email = TextEditingController(), _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void Function() change() {
    setState(() {
      _hide = !_hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: getAppBar(context: context, route: ''),
        backgroundColor: Colors.grey[400],
        body: Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: 700,
                width: 700,
                child: Card(
                  margin: EdgeInsets.all(100),
                  elevation: 20,
                  child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Builder(
                          builder: (context) => Form(
                               key: _formKey,
                               //autovalidateMode:AutovalidateMode.always,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Inicio de sesión',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    getTextForm(
                                        _email, 'Correo electrónico', false),
                                    getTextForm(_pass, 'Contraseña', _hide),
                                    ElevatedButton(
                                      onPressed: () async {
                                        FormState state = _formKey.currentState;
                                        if(state.validate()){
                                        final user = await AuthProvider
                                            .signInWithEmailPassword(
                                                context,
                                                _email.text.trim().toLowerCase(),
                                                _pass.text.trim());

                                        if (user.uid != null)
                                          Navigator.pushReplacementNamed(
                                              context, '/');}
                                      },
                                      child: Text('Iniciar sesión'),
                                    )
                                  ],
                                ),
                              ))),
                ),
              )),
        ));
  }

  Widget getTextForm(controller, hint, hide) {
    bool flag = hint == 'Contraseña';

    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        icon: (flag) ? Icon(Icons.lock) : Icon(Icons.person_pin_rounded),
        labelText: hint,
        suffixIcon: (flag)
            ? IconButton(
                onPressed: change,
                icon: (hide)
                    ? Icon(Icons.remove_red_eye_outlined)
                    : Icon(Icons.remove_red_eye),
              )
            : Container(
                height: 1,
                width: 1,
              ),
      ),
      controller: controller,
      obscureText: hide,
      maxLength: 50,
      validator: (flag) ? passwordValidator : emailValidator,
    );
  }

  String emailValidator(String value) {
    final pattern = RegExp(r'^[\w\-\._]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.isEmpty) 
      return 'Debe llenar este campo *';
    else if(value.length < 7)
      return 'correo muy corto';
    else if(!pattern.hasMatch(value))
      return '''Ingrese un correo válido.
Sólo se permiten caracteres alfanuméricos, "_" , "-" y "."''';

    return null;
  }

  String passwordValidator(String value) {
     final pattern = RegExp(r'^[a-zA-Z\.\-_]+$');
       //r'^[a-z]+[A-Z]+[\.\-_]+|[a-z]+[A-Z]+[\.\-_]+|[a-z]+[\.\-_]|[a-z]+[A-Z]+[\.\-_]|[a-z]+[A-Z]+[\.\-_]|[a-z]+[A-Z]+[\.\-_]$');
   //                         r'^[a-z]+[A-Z]+[0-9]+[._-]+.,$');
    if (value.isEmpty) 
      return 'Debe llenar este campo *';
    else if(value.length < 7 )
    return 'La contraseña debe ser mayor a 6 caracteres'; 
    else if (!pattern.hasMatch(value))
     return  '''Sólo se permiten caracteres alfanuméricos,"_" , "-" y "."'''; 

    return null;
  }
}
