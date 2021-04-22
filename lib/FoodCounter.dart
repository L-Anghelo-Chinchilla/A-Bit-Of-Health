import 'package:flutter/material.dart';
class FoodCounter extends StatefulWidget {
  FoodCounter({Key key}) : super(key: key);

  @override
  _FoodCounterState createState() => _FoodCounterState();
}

class _FoodCounterState extends State<FoodCounter> {
 
  @override
  Widget build(BuildContext context) {
    // String _formatdate = new DateFormat.yMMMd().format(_currentDate);
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Añadir Comidas\n  Cantidades',
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
          SizedBox(
              height: 60,
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.4,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Calientes',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15),
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.4,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Panes',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15),
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.4,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Acompañantes',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15),
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                  ])),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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

//-----------------------------------ITERATIVE FORMAT---------------------------------
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
