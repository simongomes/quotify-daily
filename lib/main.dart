import 'package:flutter/material.dart';
import './views/screens/quote/quote_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotify Daily',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Didact Gothic',
        primaryColor: Color.fromRGBO(33, 34, 38, 1),
        accentColor: Color.fromRGBO(104, 82, 219, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
              color: Color.fromRGBO(186, 187, 191, 1),
            fontSize: 24
          ),
          headline6: TextStyle(color: Color.fromRGBO(186, 187, 191, 1)),
        ),
      ),
      home: QuoteScreen(),
    );
  }
}
