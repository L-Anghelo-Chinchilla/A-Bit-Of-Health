import 'package:a_bit_of_health/History.dart';
import 'package:a_bit_of_health/Today.dart';
import 'package:a_bit_of_health/models/FoodModel.dart';
import 'package:a_bit_of_health/providers/FoodProvider.dart';
import 'package:a_bit_of_health/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'Login.dart';
import 'models/UserModel.dart';

import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'providers/authentification.dart';
import 'webDownload.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserModel>(context, listen: false).userID);
    if (Provider.of<UserModel>(context, listen: false).userID == null)
      return FutureBuilder<bool>(
          future: AuthProvider.getUser(context),
          builder: (context, AsyncSnapshot<bool> future) {
            if (future.hasData) {
              if (future.data)
                return HistoryViewPage();
              else
                return Login();
            } else {
              return Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 250,
                width: 250,
              ));
            }
          });
    else
      return HistoryViewPage();
  }
}

class HistoryViewPage extends StatelessWidget {
  HistoryViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool enabled = false;
    Map<String, FoodRegister> map = Map();
    Tuple2<String, String> range = ModalRoute.of(context).settings.arguments;
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else if (range == null)
      return History();
    else
      return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1543364195-077a16c30ff3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2560&q=80'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'History'),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(19),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Registros desde ${range.item1} hasta ${range.item2}',
                        style: TextStyle(fontFamily: 'Mont', fontSize: 25)),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                       

                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: FutureBuilder(
                            future: FoodProvider.getUserRegisterRange(
                                Provider.of<UserModel>(context, listen: false)
                                    .userID,
                                range.item1,
                                range.item2),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length > 0) {
                                  map = snapshot.data;
                                  enabled = true;
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, i) {
                                      return getRegisterList(
                                          context,
                                          snapshot.data.values.elementAt(i),
                                          false);
                                    },
                                  );
                                } else
                                  return getNoRegisterSignal();
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text('Atrás', style: TextStyle(fontSize: 18)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                            //onLongPress:  ,
                            onPressed: () {
                              if (enabled) {
                                _createPDF(
                                    Provider.of<UserModel>(context,
                                            listen: false)
                                        .name,
                                    range.item1,
                                    range.item2,
                                    map);
                              } else {
                                showMessage(context);
                              }
                            },
                            child: Text('Descargar',
                                style: TextStyle(fontSize: 18)))
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      );
  }

  showMessage(context) {
    final snackBar = SnackBar(
      content: Text('Nada que descargar :('),
      action: SnackBarAction(
        label: 'Aceptar',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget getNoRegisterSignal() {
    return Padding(
      padding: EdgeInsets.all(19),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No existen registros entre estas fechas.',
            style: TextStyle(fontSize: 23, fontFamily: 'Mont3'),
          ),
          SizedBox(
            height: 50,
          ),
          Image.asset('assets/patata.png')
        ],
      ),
    );
  }

  Future<void> _createPDF(
      String name, String date1, String date2, Map map) async {
    PdfDocument document = PdfDocument();
  
    //var imagen = await rootBundle.load('assets/image.png');

    createFirst(document, date1, date2, name);
    int g = 0;
    String pageDate = '';
    PdfLayoutResult lr;
    for (int i = 0; i < map.length; i++) {
      String auxDate = map.values.elementAt(i).date;

      if (auxDate == pageDate) {
        lr = writeFood(document, map.values.elementAt(i), lr);
        //pageDate = map.values.elementAt(g).date;
      } else {
        lr = createNext(document, map.values.elementAt(i));
        g = i;
        //pageDate = map.values.elementAt(g).date;
      }
      pageDate = map.values.elementAt(g).date;
    }

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Historial.pdf');
  }

  PdfLayoutResult createNext(PdfDocument document, FoodRegister register) {
    PdfLayoutResult layoutResult;
    //Creamos una nueva pagina para escribir
    final page = document.pages.add();

    PdfGrid gridH = PdfGrid();
    gridH.columns.add(count: 1);
    PdfGridRow row = gridH.rows.add();
    row.cells[0].value = '${register.date}';
    gridH.style.cellPadding = PdfPaddings(left: 5, top: 5);
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 24),
    );
    row.cells[0].style.borders.all = PdfPens.transparent;

    layoutResult = gridH.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 0, page.getClientSize().width, page.getClientSize().height),
    );

    PdfLayoutResult lr = writeFood(document, register, layoutResult);
    layoutResult = lr;
    return layoutResult;
  }

  PdfLayoutResult writeFood(
      PdfDocument document, FoodRegister register, PdfLayoutResult lr) {
    PdfLayoutResult layoutResult = lr;
    var page = document.pages[document.pages.count - 1];

    //Escribimos el tipo de comida y la hora
    PdfGrid gridTF = PdfGrid();
    gridTF.columns.add(count: 1);
    //PdfGridRow rowTF = gridTF.rows.add();
    PdfGridRow rowTF = gridTF.headers.add(1)[0];
    rowTF.cells[0].value =
        '${register.food.typeOfFood}         ${register.time}';
    rowTF.cells[0].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 12,
            style: PdfFontStyle.regular),
        backgroundBrush: PdfBrushes.orange);
    gridTF.style.cellPadding = PdfPaddings(left: 5, top: 5);
    layoutResult = gridTF.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10,
          page.getClientSize().width, page.getClientSize().height),
    );

    //EScribimos la tabla de detalles
    PdfGrid grid = PdfGrid();

    grid.columns.add(count: 4);

    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Alimento';
    headerRow.cells[1].value = 'Porción';
    headerRow.cells[2].value = 'Cantidad';
    headerRow.cells[3].value = 'Calorías';

    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

    register.food.aliments.forEach((element) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = element.name;
      row.cells[1].value = element.portion;
      row.cells[2].value = '${element.cant}';
      row.cells[3].value = (element.calories * element.cant).toStringAsFixed(1);
    });

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

    layoutResult = grid.draw(
      page: document.pages[document.pages.count - 1],
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10,
          page.getClientSize().width, page.getClientSize().height),
    );

    //Escribimos las clorias y la puntuacion total
    PdfGrid grid2 = PdfGrid();
    grid2.columns.add(count: 2);

    PdfGridRow row2 = grid2.rows.add();
    row2.cells[0].value = 'Puntuación: ${register.score}';
    row2.cells[1].value = 'Total de calorías: ${register.calories}';

    grid2.style.cellPadding = PdfPaddings(left: 5, top: 5);
    row2.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 10),
    );
    row2.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 10),
    );
    layoutResult = grid2.draw(
      page: document.pages[document.pages.count - 1],
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10,
          page.getClientSize().width, page.getClientSize().height),
    );
    return layoutResult;
  }

  int substractionDates(String date1, String date2) {
    var day1 = DateTime.parse(date1);
    var day2 = DateTime.parse(date2);
    int diference;
    diference = day2.difference(day1).inDays;
    return diference;
  }

  void createFirst(
      PdfDocument document, String date1, String date2, String name) {
    final page = document.pages.add();

    //Poner logo
    page.graphics.drawString(
        'A BIT OF HEALTH', PdfStandardFont(PdfFontFamily.helvetica, 25),
        brush: PdfBrushes.black, bounds: Rect.fromLTWH(0, 0, 300, 30));
    page.graphics.drawString('Diario de comidas, seguimiento y control',
        PdfStandardFont(PdfFontFamily.helvetica, 15),
        brush: PdfBrushes.black, bounds: Rect.fromLTWH(0, 35, 500, 20));
    /*page.graphics.drawImage(
      PdfBitmap(await _readImageData('image.png')),
      Rect.fromLTWH(
        0, 0, page.getClientSize().width, page.getClientSize().height)
    );*/
    /*page.graphics.drawImage(
    PdfBitmap(imagen.readAsBytesSync()),
    Rect.fromLTWH(
        0, 0, 500, 50));*/

    /*var myFile = File('/assets/image.png');
    final Uint8List imageData = myFile.readAsBytesSync();
    //Load the image using PdfBitmap.
    final PdfBitmap image = PdfBitmap(imageData);
    //Draw the image to the PDF page.
    document.pages
      .add()
      .graphics
      .drawImage(image, const Rect.fromLTWH(0, 0, 500, 200));*/

    //Poner titulo
    page.graphics.drawString(
        'Resumen de registros', PdfStandardFont(PdfFontFamily.helvetica, 25),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(135, page.getClientSize().height - 550, 300, 50));

    //Poner limite de fechas
    page.graphics.drawString('Desde: $date1 \n Hasta: $date2',
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(180, page.getClientSize().height - 500, 300, 50));

    //Poner nombre de usuario
    page.graphics.drawString(
        'NOMBRE: $name', PdfStandardFont(PdfFontFamily.helvetica, 18),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(150, page.getClientSize().height - 400, 300, 50));
  }

  /*Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }*/

}
