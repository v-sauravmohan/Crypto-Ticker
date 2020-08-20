import 'package:bitcoin_exchange_ticker/services/constants.dart';
import 'package:flutter/material.dart';

class TickerCard extends StatelessWidget {
  const TickerCard({
    Key key,
    @required this.cryptoCurrency,
    @required this.exchangeRate,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String cryptoCurrency;
  final String exchangeRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: kTickerYellow,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $exchangeRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: kTickerBrown,
            ),
          ),
        ),
      ),
    );
  }
}
