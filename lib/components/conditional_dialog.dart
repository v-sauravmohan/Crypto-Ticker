import 'package:bitcoin_exchange_ticker/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ConditionalDialog extends StatelessWidget {
  final bool isTrue;
  final String dialogForTrue;
  final String dialogForFalse;

  ConditionalDialog({this.isTrue, this.dialogForTrue, this.dialogForFalse});

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) => this.isTrue,
      widgetBuilder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              dialogForTrue,
              style: TextStyle(color: kTickerBrown),
            ),
          ),
        );
      },
      fallbackBuilder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              dialogForFalse,
              style: TextStyle(color: kTickerBrown),
            ),
          ),
        );
      },
    );
  }
}
