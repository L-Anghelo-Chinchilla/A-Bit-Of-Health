import 'dart:js';

import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider{

static final FirebaseAuth _auth = FirebaseAuth.instance;

static String uid;
static String userEmail;
static String userName;

static Future<User> signInWithEmailPassword(context,String email, String password) async {
  //await Firebase.initializeApp();
  User user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      
      Provider.of<UserModel>(context , listen:false).setUser(await UserProvider.getUserData(user.uid));
      uid = user.uid;
      userEmail = user.email;
      //final username = user.displayName; 
        //print (username);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);
     // await prefs.setString('userName', username);
      await prefs.setString('userID', uid);
      await prefs.setString('userName',
      Provider.of<UserModel>(context , listen:false).name);

    }
    userName = Provider.of<UserModel>(context , listen:false).name;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}


static Future<bool> getUser(BuildContext context) async {
  // Initialize Firebase
 // await Firebase.initializeApp();


  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  bool authSignedIn = prefs.getBool('auth') ?? false;
  
  bool exist = false;
  
  print(authSignedIn);
  final User user = _auth.currentUser;
  
  //var model =UserModel();
  if (authSignedIn) {
  
      String s = prefs.getString('userID');
  

    if (s != null) {
      print(s);
  
      UserModel usr =  await UserProvider.getUserData(s);
      print(usr);
      Provider.of<UserModel>(context, listen:false).setUser(usr);
       await UserProvider().checkUserGlasses(usr.userID);
    await UserProvider().updateTodayGlasses(usr.userID);
 
      exist = true;
    //  name = user.displayName;
  
     // userEmail = user.email;
    //  imageUrl = user.photoURL;
    }
  }
  
  return exist;
}


static getName() => userName; 
/*

static Future<User> registerWithEmailPassword(String email, String password) async {
  // Initialize Firebase
 // await Firebase.initializeApp();
  User user;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;
    }
  } catch (e) {
    print(e);
  }

  return user;
}


*/
static Future<String> signOut() async {
//  await Firebase.initializeApp();
   await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('auth', false);
  await prefs.setString('userName' , '');
  await prefs.setString('userID', '' );
  await prefs.remove('userName');
  await prefs.remove('userID');
  

   uid = null;
   userEmail = null;
  print('done!');
  return 'User signed out';
}

}