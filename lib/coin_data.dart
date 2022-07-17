import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'BFD0D65E-59A2-423E-B227-F78D7D6EA587';

class CoinData {
  Future getCoinData(String? currency) async {
    Map<String, String> exchangeRates = {};

    for (String crypto in cryptoList) {
      var url = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var coinData = jsonDecode(response.body);
        double exchangeRate = coinData['rate'];
        exchangeRates[crypto] = exchangeRate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return exchangeRates;
  }
}
