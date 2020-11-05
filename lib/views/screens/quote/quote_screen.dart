import 'package:flutter/material.dart';
import '../../../models/quote.dart';
import '../../../utils/db_helper.dart';
import './local_widgets/build_quote.dart';
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
        appBar: topAppBar(context, quoteSnapshot),
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

  AppBar topAppBar(BuildContext context, AsyncSnapshot<dynamic> quoteSnapshot) {
    final Quote quote = quoteSnapshot.data;
    if(quote.isFavorite) {
        _isFavorite = true;
    } else {
        _isFavorite = false;
    }

    return AppBar(
      elevation: 0,
      title: Text(greeting()),
      actions: [
        IconButton(
          icon: _isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border_rounded),
          color: Theme.of(context).accentColor,
          onPressed: () async {

            if(!_isFavorite) {
              DBHelper.insert('user_favorite_quotes', quote.toMap());
              final data = await DBHelper.getData('user_favorite_quotes');
              setState(() {
                _isFavorite = true;
              });

            } else {
              await DBHelper.deleteFavoriteQuote(quote.id);
              setState(() {
                _isFavorite = false;
              });
            }
          },
        )
      ],
    );
  }
}

