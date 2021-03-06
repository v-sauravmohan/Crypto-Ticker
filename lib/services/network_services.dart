import 'dart:convert';

import 'package:http/http.dart' as http;

import 'constants.dart';

class NetworkService {
  http.Response _response;
  String _url;
  Map<String, String> _headers = {kCustomHeader: kPublicKey};

  final List<String> cryptoCurrencies;
  final List<String> currencies;

  NetworkService({this.cryptoCurrencies, this.currencies});

  Future<dynamic> getPriceData() async {
    var crypto = cryptoCurrencies.join(',');
    var fiat = currencies.join(',');
    _url = '$kDomain/indices/global/ticker/all?crypto=$crypto&fiat=$fiat';
    _response = await http.get(_url, headers: _headers);
    if (_response.statusCode == 200) {
      return jsonDecode(_response.body);
    }
    return jsonDecode('bad_response');
  }
}
