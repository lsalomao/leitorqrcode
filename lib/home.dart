import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String code = "";

    scanQrCode() async {
      try {
        final result = await BarcodeScanner.scan();

        setState(
          () {
            var format = result.format;
            var formatNote = result.formatNote;
            var type = result.type;
            code = "Resultado: " + result.rawContent;

            print(code);
          },
        );
      } catch (e) {
        print("Erro" + e);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Leitor QR Code"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                child: Text("Scan QR code"),
                onPressed: () => scanQrCode(),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Resultado: "),
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          code,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
