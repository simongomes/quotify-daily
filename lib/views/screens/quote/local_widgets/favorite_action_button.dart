import 'package:flutter/material.dart';
import '../../../../models/quote.dart';
import '../../../../utils/db_helper.dart';

class FavoriteActionButton extends StatefulWidget {
  final Quote _quote;

  FavoriteActionButton(this._quote);

  @override
  _FavoriteActionButtonState createState() => _FavoriteActionButtonState();
}

class _FavoriteActionButtonState extends State<FavoriteActionButton> {
  bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget._quote.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border_rounded),
      color: Theme.of(context).accentColor,
      onPressed: () async {
        if(!_isFavorite) {
          DBHelper.insert('user_favorite_quotes', widget._quote.toMap());
          final data = await DBHelper.getData('user_favorite_quotes');
          setState(() {
            _isFavorite = true;
          });
        } else {
          await DBHelper.deleteFavoriteQuote(widget._quote.id);
          setState(() {
            _isFavorite = false;
          });
        }
      },
    );
  }
}