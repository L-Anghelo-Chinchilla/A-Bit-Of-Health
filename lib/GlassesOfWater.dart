
import 'package:a_bit_of_health/models/UserModel.dart';
import 'package:a_bit_of_health/providers/UserProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';

class GlassesOfWater extends StatelessWidget {
  UserProvider _provider = UserProvider();
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: getAppBar(context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo_agua.jpg'),
              fit: BoxFit.cover
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            getDirectionsBar(context , 'GlassesOfWater'),
            Expanded(
                child: Center(
                    child:
           FutureBuilder<UserModel>(
              future: _provider.getUserData(
                  '-wqweqwewqeqwewq'), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.hasData) {
                  return GlassesOfWater1(user: snapshot.data);
                } else {
                  return Center(
                      child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ));
                }
              }) //

          // GlassesOfWater1(user: UserModel(weight: 85.3, height: 1.7, email: "sanchopanza@gmail.com", gender: "M", name: "Sancho Panza", waterLimit: 10, newWaterLimit: 8, waterLimitDate: "14/04/2021", glasses: 3) )//ModalRoute.of(context).settings.arguments )
          ))]),
        ));
  }
}

class GlassesOfWater1 extends StatefulWidget {
  GlassesOfWater1({Key key, this.user}) : super(key: key);
  UserModel user;

  @override
  _GlassesOfWatterState createState() => _GlassesOfWatterState();
}

class _GlassesOfWatterState extends State<GlassesOfWater1> {
  UserProvider provider = UserProvider();



  @override
  Widget build(BuildContext context) {
    return
                       Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Vasos de agua\n', style: TextStyle(fontFamily: 'Mont', fontSize: 32)),
                              Expanded(
                                  child:
                                   Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white.withOpacity(0.7),
                                      ),
                                      height:double.infinity ,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: widget.user.waterLimit,
                                        padding: EdgeInsets.all(7),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          print(
                                              '$i  ${widget.user.waterLimit}');
                                          var state = (i < widget.user.glasses)
                                              ? 'lleno'
                                              : 'vacio';
                                          return Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  'lib/assets/vaso_$state.png',
                                                  width: 150,
                                                  height: 150,
                                                ),
                                                Text('${i + 1}',
                                                    style: TextStyle(
                                                        color:  (i < widget.user.glasses) 
                                                        ?Colors.white
                                                        :Color(0xFF3FBCF0))),
                                              ]);
                                        },
                                      )
                                      ),
                                      ),
                              SizedBox(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    child: Text('Vaciar un vaso'),
                                    onPressed: () async {
                                      if (widget.user.glasses > 0) {
                                        widget.user.glasses--;
                                        provider.setUserWaterGlasses(
                                            widget.user.userID,
                                            widget.user.glasses);
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Ya no puedes quitar más vasos!, ¿o sí?'),
                                          action: SnackBarAction(
                                            label: 'No. no puedo',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                  ElevatedButton(
                                      child: Text('Llenar un vaso'),
                                      onPressed: () async {
                                        if (widget.user.glasses <
                                            widget.user.waterLimit) {
                                          widget.user.glasses++;
                                          await provider.setUserWaterGlasses(
                                              widget.user.userID,
                                              widget.user.glasses);
                                            if(widget.user.glasses == widget.user.waterLimit){
                                              final snackBar = SnackBar(
                                            content: Text('''¡¡¡Felicidades!!! ¡Completaste tus vasos diarios!.'''),
                                            action: SnackBarAction(
                                              label: 'Gracias!',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);



                                            }
                                        } else {
                                          final snackBar = SnackBar(
                                            content: Text('''No tienes mas vasos que llenar, si quieres puedes aumentar tu limite diario de vasos de agua.'''),
                                            action: SnackBarAction(
                                              label: 'Gracias!',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                        setState(() {});
                                      })
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                Text('''¿Cuántos vasos puedes tomar al día?: 
(Los cambios se harán el día de mañana.)'''
                                  , style: TextStyle(fontFamily: 'Sans', fontSize: 22.0),),

                                CounterView(initNumber: widget.user.newWaterLimit),
                              
                                ]
                                  )
                            ],
                          ));
  }
}



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
          Text( '  ${_currentCount.toString()}  ' ),
          _createIncrementDicrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState((){
      if(_currentCount < 15){
      
      _currentCount++;
      _counterCallback(_currentCount);
      _increaseCallback();
      final provider =UserProvider();
      provider.setUserWaterLimit('-wqweqwewqeqwewq', _currentCount );
    }});
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 5) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
         final provider =UserProvider();
       provider.setUserWaterLimit('-wqweqwewqeqwewq', _currentCount );

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
