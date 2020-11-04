import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/greeting.dart';
import '../widgets/build_quote.dart';
import '../../services/quoteApi.dart';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      appBar: topAppBar(context),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 70),
          child: FutureBuilder(
            future: QuoteApi().getQuote(),
            builder: (_, quoteSnapshot) =>
                quoteSnapshot.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator()
                    : BuildQuote(quote: quoteSnapshot.data),
          ),
        ),
      ),
    );
  }

  AppBar topAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(greeting()),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.favorite_border_rounded),
      //     color: Theme.of(context).accentColor,
      //     onPressed: (){},
      //   )
      // ],
    );
  }
}

