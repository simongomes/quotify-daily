import 'package:flutter/material.dart';
import '../../models/quote.dart';

class BuildQuote extends StatelessWidget {
  final Quote quote;
  const BuildQuote({
    this.quote,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "“",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 80),
          ),
          Text(
            quote.content,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Text(
                "- ${quote.author}",
                style: TextStyle(
                    color: Colors.white54,
                    fontFamily: "OpenSans Light Italic"),
                textAlign: TextAlign.right,
              )),
        ],
      ),
    );
  }
}