import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

Future<Horoscope> fetchHoroscope(String sign) async {
  final response = await http
      .get(Uri.parse('https://ohmanda.com/api/horoscope/'+sign.toLowerCase()));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Horoscope.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Horoscope');
  }
}




class Horoscope {
  final String sign;
  final String date;
  final String horoscope;

  Horoscope({
    required this.sign,
    required this.date,
    required this.horoscope,
  });

  factory Horoscope.fromJson(Map<String, dynamic> json) {
    return Horoscope(
      sign: json['sign'],
      date: json['date'],
      horoscope: json['horoscope'],
    );
  }

}