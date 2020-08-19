import 'package:bitcoin_exchange_ticker/price_screen.dart';
import 'package:bitcoin_exchange_ticker/services/constants.dart';
import 'package:bitcoin_exchange_ticker/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  NetworkService networkService = NetworkService(
    cryptoCurrencies: kCryptoList,
    currencies: kCurrenciesList,
  );

  @override
  void initState() {
    super.initState();
    fetchPreRequisite();
  }

  void fetchPreRequisite() async {
    try {
      var priceData = await networkService.getPriceDataFromBitcoinAverage();
      if (priceData == 'bad_response') {
        throw 'bad_response';
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return PriceScreen(
            priceData: priceData,
          );
        }),
      );
    } catch (err) {
      if (err == 'bad_response') {
        print('bad Response');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SpinKitCubeGrid(
              color: kTickerYellow,
              size: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                'Fetching ticker data',
                style: TextStyle(color: kTickerBrown),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
