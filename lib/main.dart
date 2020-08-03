import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'leitorQrCode',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark),
      home: MyHomePage(title: 'Leitor Qr Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resultado = "";

  void initAppCenter() async {
    var appSecret = "83709946-de6a-418f-b482-21151ce17c7f";
    await AppCenter.start(appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
  }

  Future<void> _scanQrCode() async {
    final result = await BarcodeScanner.scan();

    setState(() {
      print(result.format);
      resultado = result.rawContent;
    });
  }

  _launchURL() async {
    var url = resultado;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: InkWell(
                child: Text(
                  resultado,
                  style: Theme.of(context).textTheme.headline6,
                ),
                onTap: _launchURL,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQrCode,
        tooltip: 'QrCode',
        child: Icon(Icons.camera),
      ),
    );
  }
}
