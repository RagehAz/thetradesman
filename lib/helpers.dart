// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:math' as math;

void blogMap(Map<dynamic, dynamic>? map, {String invoker = ''}) {

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
  required int? num,
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

int concludeNumberOfDigits(int? length) {
  int _length = 0;

  if (length != null && length != 0) {
    _length = modulus(length.toDouble()).toInt();
    _length = _length.toString().length;
  }

  return _length;
}

double modulus(double? num) {
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


/*
https://www.amazon.com/2021-Apple-10-2-inch-iPad-Wi-Fi/dp/B09G9CJM1Z?&linkCode=ll1&tag=bldrs07-20&linkId=bc6556dc4cb1bacd7dac5810dacf5e39&language=en_US&ref_=as_li_ss_tl
https://www.amazon.com/dp/B0BJLT98Q7?&linkCode=ll1&tag=bldrs07-20&linkId=b991e53f85dcc27ea135bc495090d8b6&language=en_US&ref_=as_li_ss_tl
 */
