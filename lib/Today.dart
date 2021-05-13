import 'package:a_bit_of_health/Login.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Today extends StatelessWidget {
  const Today({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodProvider provider = FoodProvider();
   // provider.uploadUserRegiter('-wqweqwewqeqwewq', '2021/5/12', FoodRegister(date : '4546546'));
    // if(Provider.of<UserModel>(context).userID == null )
    // return Login();
    // else
     if(Provider.of<UserModel>(context).userID ==null)
      return Login();
    else
         return Scaffold(
        appBar: getAppBar(context:context),
        body: Container(
           decoration: BoxDecoration(
           image: DecorationImage(
              image: AssetImage('fondo_inicio.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'Today'),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: FutureBuilder(
                  future: provider.getUserRegister(Provider.of<UserModel>(context, listen: false).userID,
                      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'),
                  builder: (context, data) {
                    if (data.hasData) if (data.data.isEmpty)
                      return getNoFoodSignal();
                    else
                      return TodayRegister(map: data.data);
                    else
                      return CircularProgressIndicator();
                  },
                ),
              ))
            ],
          ),
        ));
  }

  Widget getNoFoodSignal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Oops! Parece que no has registrado nada aún.',
          style: TextStyle(fontSize: 30),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(29.0),
          child: Image.asset(
            'lib/assets/vaso_lleno.png',
          ),
        )),
        /*ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'FoodSelector');
            },
            child: Text('Añadir comida'))*/
      ],
    );
  }
}

class TodayRegister extends StatefulWidget {
  TodayRegister({Key key, this.map}) : super(key: key);
  Map<String, FoodRegister> map;

  @override
  _TodayRegisterState createState() => _TodayRegisterState();
}

class _TodayRegisterState extends State<TodayRegister> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final caloriesSum = widget.map.values
        .fold(0, (previousValue, element) => previousValue + element.calories);
    double todayScore = widget.map.values
        .fold(0, (previousValue, element) => previousValue + element.score);
    todayScore = (todayScore + 0.0) / widget.map.length;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getScoreView(
            'Calorías de día',
            '$caloriesSum',
          ),
          getScoreView(
            'Puntuación de día',
            '${todayScore.toStringAsFixed(1)}',
          ),
        ],
      ),
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                                  color: Color(0xffffffff).withOpacity(0.9),
                                 // border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(7))),
              
              child: Scrollbar(
                thickness: 13,
                //controller: _controller ,
                isAlwaysShown: true,
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: widget.map.length,
                  itemBuilder: (context, i) {
                    String key = widget.map.keys.elementAt(i);
                    final len = widget.map.length;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 20, 5),
                            decoration: BoxDecoration(
                               color:Colors.orange[400] ,
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              border: Border.all(color: Colors.black45),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${widget.map.values.elementAt(len-1-i).food.typeOfFood} ${getEmoji(widget.map.values.elementAt(len-1-i).food.typeOfFood)}'),
                                  Text(
                                      '🕰️ ${widget.map.values.elementAt(len-1-i).time}'),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        showAlertDialog(
                                            context,
                                            '-wqweqwewqeqwewq',
                                            widget.map.values.elementAt(len-1-i).date,
                                            widget.map.values.elementAt(len-1-i).id);

                                        /*final provider = FoodProvider();
                                        await provider.deleteRegisterByDate(
                                            final provider = FoodProvider();
                                        await provider.deleteRegisterByDate(
                                            '-wqweqwewqeqwewq',
                                            widget.map.values.elementAt(i).date,
                                            widget.map.values.elementAt(i).id);,
                                            widget.map.values.elementAt(i).date,
                                            widget.map.values.elementAt(i).id);
                                        setState(() {
                                          widget.map.remove(key);
                                        });*/
                                      })
                                ])),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 250,
                            width: 500,
                            child: SingleChildScrollView(
                              child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Alimento(s)'),),
                                    DataColumn(label: Text('Porción(es)')),
                                    DataColumn(label: Text('Calorías')),
                                  ],
                                  rows: widget.map.values
                                      .elementAt(len-1-i)
                                      .food
                                      .aliments
                                      .map((element) => DataRow(cells: [
                                            DataCell(Text(element.name)),
                                            DataCell(Text('${element.cant}')),
                                            DataCell(Text(
                                                '${element.calories * element.cant}'))
                                          ]))
                                      .toList()),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4D03F),
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.all(Radius.circular(7))
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    'Calorías: ${widget.map.values.elementAt(len-1-i).calories}')),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4D03F),
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.all(Radius.circular(7))
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    'Puntuación: ${widget.map.values.elementAt(len-1-i).score}'))
                          ],
                        )
                      ],
                    );
                  },
                ),
              )))
    ]);
  }

  Widget getScoreView(String title, String score) {
    return Column(
      children: [
        Container(
          // width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.amber,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Center(child: Text(score , style: TextStyle(fontSize:30 ),)),
        ),
        Text(title, style: TextStyle(fontSize:30 ))
      ],
    );
  }

  String getEmoji(type) {
    switch (type) {
      case 'Desayuno':
        return '☕';
      case 'Almuerzo':
        return '🥣';
      case 'Cena':
        return '🥗';
      case 'Snack':
        return '🍟';
      default:
        return '';
    }
  }

  showAlertDialog(
      BuildContext context, String userID, String date, String registerID) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Eliminar"),
      onPressed: () async {
        final provider = FoodProvider();
        await provider.deleteRegisterByDate(userID, date, registerID);

        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'Today');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar registro"),
      content: Text(
          "¿Eliminar éste registro de comida?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
