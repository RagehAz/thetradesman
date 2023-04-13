// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:puppeteer/puppeteer.dart' as pup;
import 'package:thetradesman/helpers.dart';

import 'cookies.dart';

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
  // -----------------------------------------------------------------------------
  Uint8List? bytes;
  final _products = [];
  // -----------------------------------------------------------------------------
  /// email : rageh-@hotmail.com
  /// password : alibabarocks
  // -----------------------------------------------------------------------------
  Future<void> _scrapAmazon() async {
    print('starting : OPENNING BROWSER');

    pup.Browser? browser;

    try {
      browser = await pup.puppeteer.launch(
        /// prevents popping chrome browser
        headless: false,
        // executablePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe',
        // userDataDir: 'C:\\Users\\rageh\\AppData\\Local\\Google\\Chrome\\User Data',
      );
    } catch (error) {
      print('error is : $error');
    }

    print('OPENED BROWSER SUCCESSFULLY');
    // await browser.close();

    final pup.Page myPage = await browser!.newPage();

    await myPage.setCookies(cookies.map((e) => pup.CookieParam.fromJson(e)).toList());

    const List<String> urls = <String>[
      'https://www.amazon.com/2021-Apple-10-2-inch-iPad-Wi-Fi/dp/B09G9CJM1Z',
      'https://www.amazon.com/dp/B09G91LXFP',
    ];

    await _getProducts(
      urls: urls,
      myPage: myPage,
    );

  }
  // --------------------
  Future<void> _getProducts({
    required List<String> urls,
    required pup.Page myPage,
  }) async {
    for (final String url in urls) {
      await _stealPage(
        myPage: myPage,
        url: url,
      );
    }

    await _createFileFromProductsJSON(_products);
  }
  // --------------------
  Future<void> _createFileFromProductsJSON(List<dynamic> products) async {
    final theJsons = json.encode(_products);

    final String _thing = '$theJsons\n\n';

    await File('output.json').writeAsString(
      _thing,
      mode: FileMode.append,
    );
  }
  // --------------------
  Future<void> _stealPage({
    required dynamic myPage,
    required String url,
  }) async {
    /// OPENS PAGE
    await myPage.goto(
      url,
      timeout: Duration.zero,
      // wait: Until.networkAlmostIdle,
      // referrer:
    );

    /// TO HOLD UNTIL PAGE INITS
    await Future.delayed(const Duration(seconds: 5));

    // /// TO SCROLL IN PAGE
    // Future<void> autoScroll() async {
    //   await myPage.evaluate(
    //     '''
    //     async ()=>{
    //       await new Promise((resolve)=>{
    //         var totalHeight = 0;
    //         var distance = 100;
    //         var timer = setInterval(()=>{
    //           var scrollHeight = document.body.scrollHeight;
    //           window.scrollBy(0,distance);
    //           totalHeight += distance;
    //           if (totalHeight >= scrollHeight - window.innerHeight){
    //             clearInterval(timer);
    //             resolve();
    //           }
    //         },100);
    //       });
    //     }
    //     ''',
    //   );
    // }

    // myPage.hover(selector)

    final imageSelectors = await myPage.evaluate(
      'document.querySelectorAll("#altImages > ul > li").length + 1',
      // args:,
    );

    print('thing is : $imageSelectors');

    for (int i = 1; i < imageSelectors; i++) {
      try {
        /// THIS HOVERS
        await myPage.hover('#altImages > ul > li:nth-child($i)');
      } catch (e) {
        continue;
      }
    }

    print('before scroll --->');
    // await autoScroll();
    print('after scroll --->');
    final script = await File('amazon_us.js').readAsString();
    print('the output is :-');
    // print(script);
    final output = await myPage.evaluate(script);
    print('--->');

    blogMap(output);

    print('--->');

    _products.add(output);
  }
  // -----------------------------------------------------------------------------
  /*
    Future<void> old() async {

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
   */
  // -----------------------------------------------------------------------------
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

            if (bytes != null)
            Image.memory(bytes!,
              height: 200,
              width: 300,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrapAmazon,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma ma
      // kes auto-formatting nicer for build methods.
    );
  }
  // -----------------------------------------------------------------------------
}

