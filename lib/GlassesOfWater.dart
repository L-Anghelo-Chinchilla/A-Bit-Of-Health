
import 'dart:html';

import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:flutter/material.dart';

class GlassesOfWater extends StatelessWidget{

  @override 
  Widget build(BuildContext context){
      //final ScreenArguments args =
       // ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      body : GlassesOfWater1(user: UserModel(weight: 85.3, height: 1.7, email: "sanchopanza@gmail.com", gender: "M", name: "Sancho Panza", waterLimit: 10, newWaterLimit: 8, waterLimitDate: "14/04/2021", glasses: 3) )//ModalRoute.of(context).settings.arguments )
    );


  }



}


class GlassesOfWater1 extends StatefulWidget{

  GlassesOfWater1({Key key,this.user}) : super(key:key);
  UserModel user ;
   
  @override 
  _GlassesOfWatterState createState() => _GlassesOfWatterState();
}


class _GlassesOfWatterState extends State<GlassesOfWater1>{
    UserProvider provider = UserProvider();
       _incrementGlasses() {
      //setState((){
       if (widget.user.glasses <  widget.user.waterLimit){  
        widget.user.glasses++;
        
//         provider.setUserWaterLimit(widget.user.userID, widget.user.glasses);

      }else{
        /* final snackBar = SnackBar(
            content: Text('¡Buen trabajo!, ¡Ya llegaste a tu limite diario!'),
            action: SnackBarAction(
              label: '¡Gracias!',
              onPressed: (){},
            ),
          );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      }
      
      
      setState((){});
    }

    _updateLimit(){}

    @override
    Widget build(BuildContext context){
      return  Card(
          child: Padding(
            padding: EdgeInsets.all(17),
            child: Column(
              children: [
                Text('Vasos de agua'),
                Expanded(
                  child:Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: widget.user.waterLimit,
                      padding: EdgeInsets.all(7),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i ){
                        print('$i  ${widget.user.waterLimit}');
                        var state = (i < widget.user.glasses)?'lleno' :'vacio'; 
                        return Stack(
                          alignment: Alignment.center,
                        children: [
                          Image.asset('lib/assets/vaso_$state.png',width: 150,height: 150,),
                          Text('${i+1}'),
                        ]);},)
                  )
                ) ,
                SizedBox(),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    
                  
                    ElevatedButton(
                      child:Text('Quitar un vaso'),
                        onPressed:(){},

                    ),
                    ElevatedButton(
                      child:Text('Llenar un vaso'),
                        onPressed:(){},// _incrementGlasses(),

                    )
                  ],
                ),

                  TextButton(onPressed: (){}, child: Text('Editar Límite'))



              ],

            ) 

          )


        
      );



    }



}

