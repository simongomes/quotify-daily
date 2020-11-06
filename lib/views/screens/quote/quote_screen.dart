import 'package:flutter/material.dart';
import './local_widgets/build_quote.dart';
import './local_widgets/favorite_action_button.dart';
import '../../../utils/greeting.dart';
import '../../../services/quoteApi.dart';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: QuoteApi().getQuote(),
      builder: (_, quoteSnapshot) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: Text(greeting()),
          actions: [
            if(quoteSnapshot.connectionState != ConnectionState.waiting) FavoriteActionButton(quoteSnapshot.data)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/quote_screen_background.png'),
              fit: BoxFit.cover,
            )
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 70),
              child: quoteSnapshot.connectionState == ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : BuildQuote(quote: quoteSnapshot.data),
              ),
            ),
        ),
        ),
    );
  }
}