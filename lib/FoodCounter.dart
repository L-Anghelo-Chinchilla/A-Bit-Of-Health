import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';

class FoodCounter extends StatelessWidget {
  //const FoodCounter({Key key}) : super(key: key);

//The date displayed in the app
  @override
  Widget build(BuildContext context) {
    return NextPage();
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key key}) : super(key: key);

  // DateTime _currentDate = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    // String _formatdate = new DateFormat.yMMMd().format(_currentDate);
    int index = 4;
    List<FoodOffer> list = ModalRoute.of(context).settings.arguments;
    //String heh = list[index].typeOfFood;
    //String hah = list[index].aliments[index].name;
    //List<String> strArr = ['Carnes', 'Guarniciones', 'Bebidas'];
    /*List<List<String>> supremeList = [
      ['pescado', 'lomo'],
      ['fideos', 'arroz', 'yucaf'],
      ['agua', 'jugo']
    ];*/

    Size size = MediaQuery.of(context).size;

    // CENTER OF THE HOME PAGE -----------------------------------------------------------

    print(ModalRoute.of(context).settings.arguments.toString());

    return Scaffold(
      appBar: getAppBar(context),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        getDirectionsBar(context),
        Text(
          'Añadir Comidas\n  Cantidades',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 32),
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
                //Provider.of<FoodOfferModel>(context)listen = false );
                return Column(children: [
                  ImagestoDisplay(imageName: list[i].typeOfFood.toLowerCase()),
                  TitleDisplay(titleName: list[i].typeOfFood),
                  ColumnsDisplay(foods: list[i].aliments)
                ]);
              },
            ), //-------------------------------------------------------------------
          ),
        ),
        /*SizedBox(
            height: 60,
            child: ListView.builder(
                // LISTVIEW OF TITLES OF TYPES OF FOODS---------------
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return TitleDisplay(titleName: list[i].typeOfFood);
                })),*/ //-----------------------------------------------------------
        /* Expanded(
          //child: Container(
          child: ListView.builder(
              // LISTVIEW OF COLUMNS WITH FOODS AND SPINNERS-------
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, i) {
                return ColumnsDisplay(foods: list[i].aliments);
              }), //------------------------------------------------
        ),*/
        Row(
          // ROW OF BUTTONS----------------
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton.extended(
                label: Text('Atrás'),
                backgroundColor: Colors.limeAccent[700],
                onPressed: () {
                  Navigator.pop(context);
                }),
            FloatingActionButton.extended(
              label: Text('Evaluar'),
              backgroundColor: Colors.limeAccent[700],
              onPressed: () {},
            )
          ],
        ), //-----------------------------
      ]),
    );
    //------------------------------------------------------------------------------
  }
}

//--------------------------------COUNTER----------------------------------------
class CounterView extends StatefulWidget {
  final int initNumber;
  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  CounterView(
      {this.initNumber,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback});
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
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _createIncrementDicrementButton(Icons.remove, () => _dicrement()),
          Text(_currentCount.toString()),
          _createIncrementDicrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
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
class ImagestoDisplay extends StatelessWidget {
  String imageName;

  ImagestoDisplay({this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 130,
        //width: 130,
        padding: EdgeInsets.all(15),
        //alignment: Alignment.center,
        child: Image.asset(
          'assets/$imageName.png',
          width: 130,
          height: 130,
        ));
  }
}

class TitleDisplay extends StatelessWidget {
  String titleName;

  TitleDisplay({this.titleName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Text(
        titleName,
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
      ),
      alignment: Alignment.center,
    );
  }
}

class ColumnsDisplay extends StatelessWidget {
  List<Food> foods;

  ColumnsDisplay({this.foods});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height * 0.35,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      alignment: Alignment.topCenter,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: foods.length,
          itemBuilder: (context, i) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('${foods[i].name}  '), CounterView()]));
          }),
    );
  }
}
//-------------------------------------------------------------------------------
