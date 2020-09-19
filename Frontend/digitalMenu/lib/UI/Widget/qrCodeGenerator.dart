import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class QRGenerator extends StatelessWidget {
  final String storeCode, storeName;
  QRGenerator({@required this.storeCode, @required this.storeName});
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();
      final image = await wrapWidget(
        doc.document,
        key: _printKey,
        pixelRatio: 2.0,
      );
      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));
      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    String data = "https://www.google.com/s=" + storeCode;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _printScreen();
        },
        child: Icon(Icons.save),
      ),
      body: SafeArea(
        child: RepaintBoundary(
          key: _printKey,
          child: Container(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$storeName",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Divider(),
                      Text(
                        "Scan QR code to check Menu Card",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QrImage(
                        data: data,
                        version: QrVersions.auto,
                        size: 240,
                        gapless: false,
                        padding: EdgeInsets.all(20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Made by\nTekeshwar Singh & Suraj Verma\nAt Silly Hacks",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
