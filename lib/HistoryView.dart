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
import 'webDownload.dart';

class HistoryView extends StatelessWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tuple2<String, String> range = ModalRoute.of(context).settings.arguments;
    if (Provider.of<UserModel>(context).userID == null)
      return Login();
    else
      return Scaffold(
        appBar: getAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('fondo_historial.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getDirectionsBar(context, 'History'),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Registros desde ${range.item1} hasta ${range.item2}',
                      style: TextStyle(fontFamily: 'Mont2', fontSize: 20)),
                  Expanded(
                      child: Container(
                    color: Colors.white.withOpacity(0.8),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: FutureBuilder(
                      future:FoodProvider.getUserRegisterRange(
                            Provider.of<UserModel>(context, listen: false)
                                .userID,
                            range.item1,
                            range.item2),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return getRegisterList(
                                    context, snapshot.data.values.elementAt(i), false);
                              },
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('Atras'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
 ),
                      ElevatedButton(onPressed: ()=> _createPDF(Provider.of<UserModel>(context, listen: false).name, range.item1, range.item2), child: Text('Descargar'))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      );
  }

  Future<void> _createPDF(String name, String date1, String date2) async {
    PdfDocument document = PdfDocument();
    var day = DateTime.parse(date1);
    String dateRegister = date1;
    var next;
    int diference = substractionDates(date1, date2);
    //var imagen = await rootBundle.load('assets/image.png');

    createFirst(document, date1, date2, name);

    for(int i = 0; i < diference+1; i++){

      //Si hay registro
      if(registerExists()==true){
        createNext(document, dateRegister);
      }

      next = new DateTime(day.year, day.month, day.day+1);
      day = next;
      dateRegister = next.toString().substring(0, 11);
    }

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  void createNext(PdfDocument document, String dateRegister) {
      String typeFood = 'Almuerzo';
      String timeFood = '12:15';
      PdfLayoutResult layoutResult;
      //Creamos una nueva pagina para escribir
      final page = document.pages.add();
      //Ponemos el header con la fecha
      //PdfPageTemplateElement header = PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
      /*header.graphics.drawString(
        'Fecha: $dateRegister', PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: const Rect.fromLTWH(0, 15, 200, 30));
      document.template.top = header;*/

      PdfGrid gridH = PdfGrid();
      gridH.columns.add(count: 1);
      PdfGridRow row = gridH.rows.add();
      row.cells[0].value = '$dateRegister';
      gridH.style.cellPadding = PdfPaddings(left: 5, top: 5);
      row.cells[0].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 24),
      );
      row.cells[0].style.borders.all = PdfPens.transparent;

      layoutResult = gridH.draw(
        page: page,
        bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, page.getClientSize().height),
      );
      
      writeFood(document, typeFood, timeFood, page, layoutResult);
      
      
  }

  void writeFood(PdfDocument document, String typeFood, String timeFood, final page, PdfLayoutResult lr) {
    PdfLayoutResult layoutResult = lr;
    
    //Escribimos el tipo de comida y la hora
    PdfGrid gridTF = PdfGrid();
    gridTF.columns.add(count: 1);
    PdfGridRow rowTF = gridTF.rows.add();
    rowTF.cells[0].value = '$typeFood   $timeFood';
    gridTF.style.cellPadding = PdfPaddings(left: 5, top: 5);
    layoutResult = gridTF.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10, page.getClientSize().width, page.getClientSize().height),
    );
      
      //EScribimos la tabla de detalles
      PdfGrid grid = PdfGrid();

      grid.columns.add(count: 3);

      final PdfGridRow headerRow = grid.headers.add(1)[0];
      headerRow.cells[0].value = 'Alimento';
      headerRow.cells[1].value = 'Porción';
      headerRow.cells[2].value = 'Calorías';

      headerRow.style.font = PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

      for(int i = 0; i < 35; i ++){
        PdfGridRow row = grid.rows.add();
        row.cells[0].value = 'Anvorguesa';
        row.cells[1].value = '550 g';
        row.cells[2].value = '1000';
      }

      grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

      layoutResult = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10, page.getClientSize().width, page.getClientSize().height),
      );
      
      //Escribimos las clorias y la puntuacion total
      PdfGrid grid2 = PdfGrid();
      grid2.columns.add(count: 2);
      
      PdfGridRow row2 = grid2.rows.add();
      row2.cells[0].value = 'Puntuación: ';
      row2.cells[1].value = 'Total de calorías: ';
      
      grid2.style.cellPadding = PdfPaddings(left: 5, top: 5);
      layoutResult = grid2.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10, page.getClientSize().width, page.getClientSize().height),
      );
  }

  int substractionDates(String date1, String date2){
    var day1 = DateTime.parse(date1);
    var day2 = DateTime.parse(date2);
    int diference;
    diference = day2.difference(day1).inDays;
    return diference;
  }

  void createFirst(PdfDocument document, String date1, String date2, String name) {
    final page = document.pages.add();

    //Poner logo
    page.graphics.drawString(
    'A BIT OF HEALTH', PdfStandardFont(PdfFontFamily.helvetica, 25),
    brush: PdfBrushes.black, bounds: Rect.fromLTWH(0, 0, 300, 30));
    page.graphics.drawString(
    'Diario de comidas, seguimiento y control', PdfStandardFont(PdfFontFamily.helvetica, 15),
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
    brush: PdfBrushes.black, bounds: Rect.fromLTWH(135, page.getClientSize().height-550, 300, 50));
    
    //Poner limite de fechas
    page.graphics.drawString(
    'Desde: $date1 \n Hasta: $date2', PdfStandardFont(PdfFontFamily.helvetica, 16),
    brush: PdfBrushes.black, bounds: Rect.fromLTWH(180, page.getClientSize().height-500, 300, 50));

    //Poner nombre de usuario
    page.graphics.drawString(
    'NOMBRE: $name', PdfStandardFont(PdfFontFamily.helvetica, 18),
    brush: PdfBrushes.black, bounds: Rect.fromLTWH(150, page.getClientSize().height-400, 300, 50));
  }

  /*Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }*/

  bool registerExists() {
    return true;
  }
}
