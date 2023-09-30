import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomCountry extends StatefulWidget {
  const RandomCountry({super.key});

  @override
  State<RandomCountry> createState() => _RandomCountryState();
}

class _RandomCountryState extends State<RandomCountry> {
  List<dynamic> countries = [];

  Future<void> fetchCountries() async {
    print('fetch being done');
    const url = 'https://restcountries.com/v3.1/all';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          countries = responseData;
        });
        print('API call successful: $countries');
      } else {
        // API call failed
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // Error during API call
      print('Error during API call: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'This is the RANDOM COUNTRY Page',
            ),
          ],
        ),
      ),
    );
  }
}
