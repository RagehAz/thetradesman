import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:puppeteer/puppeteer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {

    // ME7TAGA LE3BA SHWAYA
    /// document.querySelectorAll(".imgTagWrapper > img")
    ///
    /// #bylineInfo
    /// brand ^
    /// document.querySelector(".a-icon-alt").innerHTML
    /// stars ^
    /// acrCustomerReviewText
    /// ratings ^
    /// #poExpander > div.a-expander-content.a-expander-partial-collapse-content.a-expander-content-expanded > div > table > tbody
    /// tbody ^
    /// #feature-bullets
    ///
    /// #detailBullets_feature_div
    /// .askTeaserQuestions
    /// #cm-cr-dp-review-list
    /// reviews^
    /// document.querySelector("#productDescription").innerText
    /// document.querySelector("#important-information").innerText
    /// 'Important information\nVisible screen diagonal\n\n0" / 0 cm'
    /// badge document.querySelector(".icon-farm-wrapper")

     // Download the Chromium binaries, launch it and connect to the "DevTools"
  var browser = await puppeteer.launch(
    headless: false,

  );

  // Open a new tab
  var myPage = await browser.newPage();

  // Go to a page and wait to be fully loaded
  await myPage.goto('https://www.amazon.eg/-/en/Xiaomi-Earphone-Built-Microphone-Silicone/dp/B01N0Z1YKE',
    timeout: const Duration(seconds: 20),
    // wait: Until.domContentLoaded,
    // referrer:
  );

  // #productTitle
  // #landingImage
  // .a-offscreen
  final dynamic productTitle = await myPage.evaluate('''
document.querySelector("#productTitle").innerText
''',
    // args:
  );
  print('productTitle : $productTitle');

  final dynamic productLandingImage = await myPage.evaluate('''
document.querySelector("#landingImage").src
''',
    // args:
  );
  print('productLandingImage : $productLandingImage');
  // await myPage.waitForSelector('flt-glass-pane',
  //   // timeout: ,
  //   // hidden: ,
  //   visible: true,
  // );

  // Do something... See other examples

  await Future.delayed(const Duration(seconds: 1),(){});

  final Uint8List _bytes = await myPage.screenshot();
  print('_bytes : ${_bytes.length} bytes');
  setState(() {
    bytes = _bytes;
  });
  // await myPage.pdf();
  // await myPage.evaluate<String>('() => document.title');

  // Gracefully close the browser's process
  // await browser.close();


  }

  Uint8List? bytes;

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


            const Text(
              'You have pushed the button this many times:',
            ),


            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            if (bytes != null)
            Image.memory(bytes!,
              height: 200,
              width: 300,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
