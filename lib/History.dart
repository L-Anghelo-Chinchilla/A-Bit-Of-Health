import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class History extends StatelessWidget {
  const History
  ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     if(Provider.of<UserModel>(context).userID ==null)
      return Login();
    else
         return Scaffold(
      appBar:getAppBar(context:context),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('fondo_historial.jpg'),
              fit: BoxFit.cover
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            getDirectionsBar(context , 'History'),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text("Selecciona el intervalo de fechas para ver tu historial", style: TextStyle(fontFamily: 'Mont', fontSize: 28)),
                ),
                Container(
                  color: Colors.white.withOpacity(0.8),
                  width: MediaQuery.of(context).size.width/2.5,
                  height: MediaQuery.of(context).size.height/2,
                 child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                       selectionMode: DateRangePickerSelectionMode.range,
                    ),
                ),
                ElevatedButton(
                onPressed: (){Navigator.pushNamed(context, 'HistoryView');},
                child: Text("Ver", style: TextStyle(fontSize: 20),)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  // TODO: implement your code here
}