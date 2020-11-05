import 'package:flutter/material.dart';
import './local_widgets/build_quote.dart';
import './local_widgets/favorite_action_button.dart';
import '../../../models/quote.dart';
import '../../../utils/greeting.dart';
import '../../../services/quoteApi.dart';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: QuoteApi().getQuote(),
      builder: (_, quoteSnapshot) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        extendBodyBehindAppBar: true,
        appBar: QuoteAppBar(title: greeting(), quote: quoteSnapshot.data,), //topAppBar(context, quoteSnapshot),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 70),
            child: quoteSnapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : BuildQuote(quote: quoteSnapshot.data),
            ),
          ),
        ),
    );
  }
}

class QuoteAppBar extends AppBar {
  QuoteAppBar({
    Key key,
    String title,
    Quote quote,
  }) : super(key: key, title: Text(title), elevation: 0, actions: [FavoriteActionButton(quote)]);
}

