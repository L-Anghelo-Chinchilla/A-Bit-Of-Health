import 'package:a_bit_of_health/FoodSelector.dart';
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:tuple/tuple.dart';
import 'Login.dart';

List<double> thecalories = [];

int num;

class FoodCounter extends StatelessWidget {
  //const FoodCounter({Key key}) : super(key: key);

//The date displayed in the app
  @override
  Widget build(BuildContext context) {
    return NextPage();
  }
}

// ignore: must_be_immutable
class NextPage extends StatelessWidget {
  //const NextPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Tuple2<String, List<FoodOffer>> thelist =
        ModalRoute.of(context).settings.arguments;
    if (thelist == null) {
      return FoodSelector();
    }
    Provider.of<List<FoodOffer>>(context, listen: false).addAll(thelist.item2);

    List<FoodOffer> list = thelist.item2;
    String kindOfFood = thelist.item1;


    // CENTER OF THE HOME PAGE -----------------------------------------------------------

    print('-> ' +
        Provider.of<List<FoodOffer>>(context, listen: false).toString());
    //appBar: getAppBar(context);
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else
      return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1516211697506-8360dbcfe9a4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80'),
                fit: BoxFit.cover),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            getDirectionsBar(context, 'FoodCounter'),
            Text(
              '\n Añadir cantidades de Alimentos',
              style: TextStyle(
                fontFamily: 'Mont',
                fontSize: 32,
              ),
            ),
            Expanded(
              child: Container(
                //alignment: Alignment.center,
                child: ListView.builder(
                  // LISTVIEW OF IMAGES ------------------------------------
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    return Column(children: [
                      ImagestoDisplay(
                          imageName: list[i].typeOfFood.toLowerCase()),
                      TitleDisplay(titleName: list[i].typeOfFood),
                      ColumnsDisplay(foods: list[i].aliments, index: i)
                    ]);
                  },
                ), //-------------------------------------------------------------------
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                // ROW OF BUTTONS----------------
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                      child: Text(
                        'Atrás',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      //backgroundColor: Colors.limeAccent[700],
                      onPressed: () {
                        Provider.of<List<FoodOffer>>(context, listen: false)
                            .clear();
                        Navigator.pop(context);
                      }),
                  ElevatedButton(
                      onPressed: () {
                        double sum = 0;
                        Provider.of<List<FoodOffer>>(context, listen: false)
                            .forEach((foodOffer) {
                          sum += foodOffer.aliments.fold(0.0,
                              (ant, food) => ant + food.calories * food.cant);
                        });
                        print('la suma es : $sum ');

                        final newList =
                            Provider.of<List<FoodOffer>>(context, listen: false)
                                .fold(<Food>[], (prev, actual) {
                          prev.addAll(actual.aliments);
                          return prev;
                        });
                        final offer = FoodOffer(
                            typeOfFood: kindOfFood, aliments: newList);
                        print('La nueva lista es ${newList.toString()}');
                        Navigator.pushNamed(context, 'Evaluation',
                            arguments: Tuple2<double, FoodOffer>(sum, offer));
                        print('FoodCounter envía: $offer');
                      },
                      child:
                          Text('Autoevaluar', style: TextStyle(fontSize: 18)))
                ],
              ),
            ), //-----------------------------
          ]),
        ),
      );
    //------------------------------------------------------------------------------
  }
}

//--------------------------------COUNTER----------------------------------------
// ignore: must_be_immutable
class CounterView extends StatefulWidget {
  int x;
  int y;
  final int initNumber;
  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  CounterView(
      {this.initNumber,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback,
      this.x,
      this.y});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int _currentCount;
  Function _counterCallback;
  Function _increaseCallback;
  Function _decreaseCallback;

  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentCount =
        Provider.of<List<FoodOffer>>(context, listen: false)[widget.x]
            .aliments[widget.y]
            .cant;
    print(Provider.of<List<FoodOffer>>(context, listen: false)[widget.x]
        .aliments[widget.y]
        .cant);
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _createIncrementDicrementButton(Icons.remove, () => _dicrement(num)),
          Text(_currentCount.toString()),
          _createIncrementDicrementButton(Icons.add, () => _increment(num)),
        ],
      ),
    );
  }

  void _increment(int n) {
    setState(() {
      if (_currentCount < 20) {
        _currentCount++;
        Provider.of<List<FoodOffer>>(context, listen: false)[widget.x]
            .aliments[widget.y]
            .setCant(_currentCount);
        _counterCallback(_currentCount);
        _increaseCallback();
      }
    });
  }

  void _dicrement(int n) {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
        Provider.of<List<FoodOffer>>(context, listen: false)[widget.x]
            .aliments[widget.y]
            .setCant(_currentCount);
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 10.0, minHeight: 10.0),
      onPressed: onPressed,
      elevation: 0.2,
      fillColor: Colors.limeAccent[700],
      child: Icon(
        icon,
        color: Colors.white,
        size: 15.0,
      ),
      shape: CircleBorder(),
    );
  }
}

//-----------------------------------ITERATIVE FORMAT---------------------------------
// ignore: must_be_immutable
class ImagestoDisplay extends StatelessWidget {
  String imageName;

  ImagestoDisplay({this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Image.asset(
          'assets/$imageName.png',
          width: 130,
          height: 130,
        ));
  }
}

// ignore: must_be_immutable
class TitleDisplay extends StatelessWidget {
  String titleName;

  TitleDisplay({this.titleName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFDC7633).withOpacity(0.8),
      width: 180.0, //MediaQuery.of(context).size.width * 0.1,
      height: 35.0, //MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Text(
        titleName,
        style: TextStyle(
          fontFamily: 'Mont2',
          fontSize: 20.0,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}

// ignore: must_be_immutable
class ColumnsDisplay extends StatelessWidget {
  List<Food> foods;
  int index;

  ColumnsDisplay({this.foods, this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 250,
        //height: MediaQuery.of(context).size.height * 0.3,
        margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFFF4D03F).withOpacity(0.9),
            border:
                Border.all(color: Colors.black)), //YELLOW xxxxxxxxxxxxxxxxxx
        alignment: Alignment.topCenter,
        child: Scrollbar(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: foods.length,
              itemBuilder: (context, i) {
                num = i;
                thecalories.add(foods[i].calories);
                return Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 17, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '''${foods[i].name} 
${foods[i].portion}''',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          CounterView(x: index, y: i)
                        ])); //xxxxxxxx
              }),
        ),
      ),
    );
  }
}
//-------------------------------------------------------------------------------
