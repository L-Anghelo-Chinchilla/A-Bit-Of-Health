import 'dart:html';

import 'package:flutter/material.dart';

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
    Size size = MediaQuery.of(context).size;

    final _TabPages = <Widget>[
      // CENTER OF THE HOME PAGE -----------------------------------------------------------

      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Añadir Comidas',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 32),
        ),
        Expanded(
          child: Container(
            //alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                    height: 100,
                    width: 100,
                    //alignment: Alignment.center,
                    child: Image.asset(
                      'assets/calientes.png',
                      width: 100,
                      height: 100,
                    )),
                Container(
                    height: 100,
                    width: 100,
                    //alignment: Alignment.center,
                    child: Image.asset('assets/frios.png',
                        width: 100, height: 100)),
                Container(
                    height: 100,
                    width: 100,
                    //alignment: Alignment.center,
                    child: Image.asset('assets/masas.png',
                        width: 100, height: 100)),
                Container(
                    height: 100,
                    width: 100,
                    //alignment: Alignment.center,
                    child: Image.asset('assets/frutas.png',
                        width: 100, height: 100)),
              ],
            ),
          ),
        ),
        Expanded(
          //child: Container(
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.4,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Tostada'),
                        CounterView(),
                      ]),
                  alignment: Alignment.topCenter,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.4,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.4,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                ),
              ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
                label: Text('Atrás'),
                backgroundColor: Colors.limeAccent[700],
                onPressed: () {}),
            FloatingActionButton.extended(
              label: Text('Evaluar'),
              backgroundColor: Colors.limeAccent[700],
              onPressed: () {},
            )
          ],
        ),
      ]),
      //------------------------------------------------------------------------------
      //CENTER OF THE STATISTICS
      Center(child: Icon(Icons.analytics)),
      //------------------------------------------------------------------------------
      //CENTER OF THEE CALENDAR
      Center(child: Icon(Icons.calendar_today_rounded)),
      //------------------------------------------------------------------------------
      //CENTER OF TODAY
      Center(child: Icon(Icons.star)),
      //------------------------------------------------------------------------------
      //const Center(child: Text("Date: $_currentDate")),
    ];

    final _KTabs = <Tab>[
      const Tab(icon: Icon(Icons.home), text: 'Inicio'),
      const Tab(icon: Icon(Icons.analytics), text: 'Estadísticas'),
      const Tab(icon: Icon(Icons.calendar_today_rounded), text: 'Calendario'),
      const Tab(icon: Icon(Icons.star), text: 'Hoy'),
    ];
    return DefaultTabController(
      length: _KTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('A Bit Of Health'),
          backgroundColor: Colors.limeAccent[700],
          brightness: Brightness.dark,
          actions: [
            Image(
              image: AssetImage('assets/ABitOfHealth.png'),
              fit: BoxFit.contain,
              height: 60,
            )
          ],
          bottom: TabBar(
            tabs: _KTabs,
          ),
        ),
        body: TabBarView(
          children: _TabPages,
        ),
      ),
    );
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

class ImagestoDisplay extends StatelessWidget {
  String imageName;

  ImagestoDisplay({this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        //alignment: Alignment.center,
        child: Image.asset(
          'assets/$imageName.png',
          width: 100,
          height: 100,
        ));
  }
}

//-------------------------------------------------------------------------------
