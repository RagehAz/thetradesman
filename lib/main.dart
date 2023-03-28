import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:puppeteer/puppeteer.dart';
import 'dart:math' as math;

import 'package:thetradesman/cookies.dart';

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

  // email : rageh-@hotmail.com
  // password : alibabarocks


  Future<void> _incrementCounter() async {

    var browser = await puppeteer.launch(
      headless: false,
      // executablePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe',
      // userDataDir: 'C:\\Users\\rageh\\AppData\\Local\\Google\\Chrome\\User Data',
    );

    var myPage = await browser.newPage();

    await myPage.setCookies(cookies.map((e) => CookieParam.fromJson(e)).toList());

    const List<String> _urls = <String>[
      'https://www.amazon.com/dp/B07BR8D713',
    ];

    for (final String url in _urls){

      await _stealPage(
        myPage: myPage,
        url: url,
      );

    }

  }

  Future<void> _stealPage({
    required dynamic myPage,
    required String url,
  }) async {

    /// OPENS PAGE
    await myPage.goto(
      url,
      // timeout: const Duration(seconds: 20),
      wait: Until.domContentLoaded,
      // referrer:
    );

    /// TO HOLD UNTIL PAGE INITS
    await Future.delayed(const Duration(seconds: 2));

    /// TO SCROLL IN PAGE
    Future<void> autoScroll() async {
      await myPage.evaluate(
        '''
        async ()=>{
          await new Promise((resolve)=>{
            var totalHeight = 0;
            var distance = 100;
            var timer = setInterval(()=>{
              var scrollHeight = document.body.scrollHeight;
              window.scrollBy(0,distance);
              totalHeight += distance;
              if (totalHeight >= scrollHeight - window.innerHeight){
                clearInterval(timer);
                resolve();
              }
            },100);
          });
        }
        ''',
      );
    }

    // myPage.hover(selector)

    final imageSelectors = await myPage.evaluate(
      'document.querySelectorAll("#altImages > ul > li").length + 1',
      // args:,
    );

    print('thing is : $imageSelectors');

    for (int i = 1; i < imageSelectors; i++){
      try {
        /// THIS HOVERS
        await myPage.hover('#altImages > ul > li:nth-child($i)');
      }


      catch (e){
        continue;
      }

    }

    print('before scroll --->');
    await autoScroll();
    print('after scroll --->');
    final script = await File('amazon_us.js').readAsString();
    print('the output is :-');
    // print(script);
    final output = await myPage.evaluate(script);
    print('--->');

    blogMap(output);

    print('--->');


  }


//   Future<void> old() async {
//
//     // ME7TAGA LE3BA SHWAYA
//     /// document.querySelectorAll(".imgTagWrapper > img")
//     ///
//     /// #bylineInfo
//     /// brand ^
//     /// document.querySelector(".a-icon-alt").innerHTML
//     /// stars ^
//     /// acrCustomerReviewText
//     /// ratings ^
//     /// #poExpander > div.a-expander-content.a-expander-partial-collapse-content.a-expander-content-expanded > div > table > tbody
//     /// tbody ^
//     /// #feature-bullets
//     ///
//     /// #detailBullets_feature_div
//     /// .askTeaserQuestions
//     /// #cm-cr-dp-review-list
//     /// reviews^
//     /// document.querySelector("#productDescription").innerText
//     /// document.querySelector("#important-information").innerText
//     /// 'Important information\nVisible screen diagonal\n\n0" / 0 cm'
//     /// badge document.querySelector(".icon-farm-wrapper")
//
//
//   // #productTitle
//   // #landingImage
//   // .a-offscreen
//   final dynamic productTitle = await myPage.evaluate('''
// document.querySelector("#productTitle").innerText
// ''',
//     // args:
//   );
//   print('productTitle : $productTitle');
//
//   final dynamic productLandingImage = await myPage.evaluate('''
// document.querySelector("#landingImage").src
// ''',
//     // args:
//   );
//   print('productLandingImage : $productLandingImage');
//   // await myPage.waitForSelector('flt-glass-pane',
//   //   // timeout: ,
//   //   // hidden: ,
//   //   visible: true,
//   // );
//
//   // Do something... See other examples
//
//   await Future.delayed(const Duration(seconds: 1),(){});
//
//   final Uint8List _bytes = await myPage.screenshot();
//   print('_bytes : ${_bytes.length} bytes');
//   setState(() {
//     bytes = _bytes;
//   });
//   // await myPage.pdf();
//   // await myPage.evaluate<String>('() => document.title');
//
//   // Gracefully close the browser's process
//   // await browser.close();
//
//
//   }

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

void blogMap(Map<dynamic, dynamic> map, {String invoker = ''}) {
  if (map != null) {
    print('$invoker ~~~> <String, dynamic>{');

    final List<dynamic> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    for (int i = 0; i < _keys.length; i++) {
      final String _index = formatIndexDigits(
        index: i,
        listLength: _keys.length,
      );

      print('         $_index. ${_keys[i]} : <${_values[i].runtimeType}>( ${_values[i]} ), ');
    }

    print('      }.........Length : ${_keys.length} keys <~~~');
  } else {
    print('MAP IS NULL');
  }
}

String formatIndexDigits({
  required int index,
  required int listLength,
}) {
  return formatNumberWithinDigits(
    digits: concludeNumberOfDigits(listLength),
    num: index,
  );
}

String formatNumberWithinDigits({
  required int num,
  required int digits,
}) {
  /// this should put the number within number of digits
  /// for digits = 4,, any number should be written like this 0000
  /// 0001 -> 0010 -> 0100 -> 1000 -> 9999
  /// when num = 10000 => should return 'increase digits to view number'

  String? _output;

  if (num != null) {
    final int _maxPlusOne = calculateIntegerPower(num: 10, power: digits);
    final int _maxPossibleNum = _maxPlusOne - 1;

    if (num > _maxPossibleNum) {
      _output = 'XXXX';
    } else {
      String _numAsText = num.toString();

      for (int i = 1; i <= digits; i++) {
        if (_numAsText.length < digits) {
          _numAsText = '0$_numAsText';
        } else {
          break;
        }
      }

      _output = _numAsText;
    }
  }

  return _output!;
}

int calculateIntegerPower({
  required int num,
  required int power,
}) {
  /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
  int _output = 1;

  for (int i = 0; i < power; i++) {
    _output *= num;
  }

  return _output;
}

int concludeNumberOfDigits(int length) {
  int _length = 0;

  if (length != null && length != 0) {
    _length = modulus(length.toDouble()).toInt();
    _length = _length.toString().length;
  }

  return _length;
}

double modulus(double num) {
  double? _val;

  /// NOTE : GETS THE ABSOLUTE VALUE OF A DOUBLE

  if (num != null) {
    _val = math.sqrt(calculateDoublePower(num: num, power: 2));
  }

  return _val!;
}

double calculateDoublePower({
  required double num,
  required int power,
}) {
  /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
  double _output = 1;

  for (int i = 0; i < power; i++) {
    _output *= num;
  }

  return _output;
}
