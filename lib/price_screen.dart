import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io' show Platform;

import 'components/conditional_dialog.dart';
import 'components/ticker_card.dart';
import 'services/constants.dart';

class PriceScreen extends StatefulWidget {
  final dynamic priceData;
  final bool isHistoricData;

  PriceScreen({this.priceData, this.isHistoricData});

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
            ConditionalDialog(
              isTrue: widget.isHistoricData,
              dialogForTrue: "This is Historic Data",
              dialogForFalse: "Updated just now",
            ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Choose currency :",
                        style: TextStyle(
                          color: kTickerBrown,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      getDropDownPicker(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
