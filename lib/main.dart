import 'package:bitcoin_exchange_ticker/loading_screen.dart';
import 'package:bitcoin_exchange_ticker/services/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: kTickerYellow, scaffoldBackgroundColor: Colors.white),
      home: LoadingScreen(),
    );
  }
}
