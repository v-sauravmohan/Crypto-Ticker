import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io' show Platform;

import 'services/constants.dart';

class PriceScreen extends StatefulWidget {
  final dynamic priceData;

  PriceScreen({this.priceData});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<DropdownMenuItem> dropdownMenuItem = [];
  List<Text> cupertinoPickerItem = [];
  String oneBTC = '?';
  String oneETH = '?';
  String oneLTC = '?';
  dynamic _priceData;

  void buildDropDownMenuItem() {
    for (String currency in kCurrenciesList) {
      dropdownMenuItem.add(buildItemWidget(currency));
    }
  }

  DropdownMenuItem buildItemWidget(String currency) {
    return DropdownMenuItem(
      child: Text(
        currency,
        style: TextStyle(
          color: kTickerBrown,
        ),
      ),
      value: currency,
    );
  }

  void buildCupertinoPickerItem() {
    for (String currency in kCurrenciesList) {
      cupertinoPickerItem.add(buildCupertinoItemWidget(currency));
    }
  }

  Text buildCupertinoItemWidget(String currency) {
    return Text(currency);
  }

  DropdownButton getDropDownButton() {
    return DropdownButton(
      value: selectedCurrency,
      items: dropdownMenuItem,
      dropdownColor: Colors.white,
      onChanged: (value) {
        selectedCurrency = value;
        updateUI();
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    //TODO Complete cupertino picker logic
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {},
      children: cupertinoPickerItem,
    );
  }

  dynamic getDropDownPicker() {
    if (Platform.isIOS) {
      return getCupertinoPicker();
    }
    if (Platform.isAndroid) {
      return getDropDownButton();
    }
  }

  updateUI() {
    setState(() {
      if (_priceData != null) {
        var btcValue = _priceData['BTC$selectedCurrency']['high'];
        oneBTC = btcValue.toString();
        var ethValue = _priceData['ETH$selectedCurrency']['high'];
        oneETH = ethValue.toString();
        var ltcValue = _priceData['LTC$selectedCurrency']['high'];
        oneLTC = ltcValue.toString();
      }
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: TextStyle(color: kTickerBrown),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(color: kTickerBrown),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(color: kTickerBrown),
                ),
              ),
              SizedBox(
                height: 30,
                width: 20,
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(color: kTickerBrown),
                ),
              ),
              SizedBox(
                height: 30,
                width: 10,
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    buildDropDownMenuItem();
    buildCupertinoPickerItem();
    _priceData = widget.priceData;
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '🤑 Crypto Ticker',
            style: TextStyle(
              color: kTickerBrown,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TickerCard(
              cryptoCurrency: kCryptoList[0],
              exchangeRate: oneBTC,
              selectedCurrency: selectedCurrency,
            ),
            TickerCard(
              cryptoCurrency: kCryptoList[1],
              exchangeRate: oneETH,
              selectedCurrency: selectedCurrency,
            ),
            TickerCard(
              cryptoCurrency: kCryptoList[2],
              exchangeRate: oneLTC,
              selectedCurrency: selectedCurrency,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  color: kTickerYellow,
                  child: getDropDownPicker(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
