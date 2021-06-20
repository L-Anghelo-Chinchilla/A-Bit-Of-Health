import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/authentification.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

String theId;

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

  Future<void> theUpdate1() async {
    await UserProvider().updateDailyCalories(theId);
  }

  Future<void> theUpdate2() async {
    await UserProvider().updateDailyGlasses(theId);
  }

  Future<void> theUpdate3() async {
    await UserProvider().updateDailyScore(theId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context: context, route: ''),
        backgroundColor: Colors.grey[400],
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1493770348161-369560ae357d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=4350&q=80'),
                    fit: BoxFit.cover)
                /* CachedNetworkImage(
   imageUrl: "http://via.placeholder.com/350x150",
   placeholder: (context, url) => new CircularProgressIndicator(),
   errorWidget: (context, url, error) => new Icon(Icons.error),
 ),*/
                //  image: AssetImage('fondo_login.jpg'), fit: BoxFit.cover),
                ),
            child: Center(
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
                                autovalidateMode: AutovalidateMode.always,
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
                                        if (state.validate()) {
                                          final user = await AuthProvider
                                              .signInWithEmailPassword(
                                                  context,
                                                  _email.text
                                                      .trim()
                                                      .toLowerCase(),
                                                  _pass.text.trim());

                                          if (user.uid != null)
                                            Navigator.pushReplacementNamed(
                                                context, '/');

                                          theId = Provider.of<UserModel>(
                                                  context,
                                                  listen: false)
                                              .userID;

                                          await theUpdate1();
                                          await theUpdate2();
                                          await theUpdate3();
                                          UserProvider()
                                              .updateLastConnection(theId);
                                        }
                                      },
                                      child: Text('Iniciar sesión'),
                                    )
                                  ],
                                ),
                              ))),
                ),
              ),
            )));
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
    else if (value.length < 7)
      return 'correo muy corto';
    else if (!pattern.hasMatch(value))
      return '''Ingrese un correo válido.
Sólo se permiten caracteres alfanuméricos, "_" , "-" y "."''';

    return null;
  }

  String passwordValidator(String value) {
    final pattern = RegExp(r'^[a-zA-Z0-9\.\-_]+$');
    //r'^[a-z]+[A-Z]+[\.\-_]+|[a-z]+[A-Z]+[\.\-_]+|[a-z]+[\.\-_]|[a-z]+[A-Z]+[\.\-_]|[a-z]+[A-Z]+[\.\-_]|[a-z]+[A-Z]+[\.\-_]$');
    //                         r'^[a-z]+[A-Z]+[0-9]+[._-]+.,$');
    if (value.isEmpty)
      return 'Debe llenar este campo *';
    else if (value.length < 7)
      return 'La contraseña debe ser mayor a 6 caracteres';
    else if (!pattern.hasMatch(value))
      return '''Sólo se permiten caracteres alfanuméricos,"_" , "-" y "."''';

    return null;
  }
}
