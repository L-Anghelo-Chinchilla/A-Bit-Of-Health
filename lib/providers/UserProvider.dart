import 'dart:convert';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:http/http.dart' as http;

class UserProvider 
{
  final _url = 'https://a-bit-of-health-default-rtdb.firebaseio.com/database/users/';  

  Future<UserModel> getUserData(String userID) async {
     final url = '$_url$userID.json';
     final answer =await http.get(url);
     Map<String , dynamic> data = json.decode(answer.body);
    UserModel userData = (UserModel.fromJson(data));
    print(userData.toJson());
    userData.setID(userID);
    return userData;
  }


  Future<bool> setUserWaterLimit(String userID , int limit)
   async{
    final url    = '$_url$userID/.json';
    var user =await getUserData(userID);
    user.waterLimit =  limit; 
    http.put(url , 
    body: user.toJson().toString() );
    return true ;
  }


}