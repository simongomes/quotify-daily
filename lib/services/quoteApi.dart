import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:quotify_daily/utils/db_helper.dart';
import '../models/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteApi {
  Quote _quote;

  // Fetch quote from API and return
  Future<Quote> getQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const storeUrl = 'https://quotify-daily-210bd.firebaseio.com/user_quotes.json';
    Response response, successResponse;

    // Make Date Time for Today
    final DateTime now = DateTime.now();
    final String today = DateTime(now.year, now.month, now.day).toIso8601String();

    try {
      final String userId = prefs.getString("user_id");

      // Check if user already exists
      if (userId == null) {
        // If user doesn't exist, request a new quote from API,
        // store the quote to the firebase
        // and save to the new user to the shared pref
        response = await Dio().get("http://api.quotable.io/random");
        successResponse = await Dio().post(storeUrl, data: jsonDecode(response.toString()));
        prefs.setString("user_id", successResponse.data['name']); // Save user_id to local storage
        prefs.setString('quote_date', today);
      } else {
        final getUrl = "https://quotify-daily-210bd.firebaseio.com/user_quotes/$userId.json";
        // Check if user entry already exists
        // Fetch the stored quote from the firebase db
        DateTime quoteDate = DateTime.parse(prefs.getString('quote_date'));

        if(quoteDate.isBefore(DateTime.parse(today))) {
          response = await Dio().get("http://api.quotable.io/random");
          successResponse = await Dio().patch(getUrl, data: jsonDecode(response.toString()));
          // Update the quote date to today
          prefs.setString('quote_date', today);
        } else {
          response = await Dio().get(getUrl);
          // check if user exist but quote is missing
          if(response.data == null) {
            response = await Dio().get("http://api.quotable.io/random");
            successResponse = await Dio().patch(getUrl, data: jsonDecode(response.toString()));
            // Update the quote date to today
            prefs.setString('quote_date', today);
          }
        }
      }
      _quote = Quote.fromJson(jsonDecode(response.toString()));

      // check if quote is favorite
      final quoteIsFavorite = await DBHelper.getQuoteById(_quote.id);
      if(quoteIsFavorite.isNotEmpty) {
        _quote.isFavorite = true;
      }
      return _quote;
    } on DioError catch (e) {
      print("DioError: $e");
    } catch (e) {
      print("error: $e");
    }
  }
}
