import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class RandomCountry extends StatefulWidget {
  const RandomCountry({super.key});

  @override
  State<RandomCountry> createState() => _RandomCountryState();
}

class _RandomCountryState extends State<RandomCountry> {
  List<dynamic> countries = [];
  bool loadedCountries = false;

  List<Widget> renderCountryInfo() {
    if (loadedCountries) {
      dynamic selectedCountry = countries[getRandomIndex(countries.length)];

      return <Widget>[
        Text(
          selectedCountry["name"]["common"],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          child: Image.network(
            selectedCountry["flags"]["png"],
          ),
        ),
      ];
    } else {
      return <Widget>[const Text('Loading...')];
    }
  }

  int getRandomIndex(int length) {
    Random random = Random();
    return random.nextInt(length);
  }

  Future<void> fetchCountries() async {
    const url =
        'https://restcountries.com/v3.1/all?fields=name,currencies,flags,languages';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          countries = responseData;
        });
        loadedCountries = true;
        print(countries[0]["name"]["common"]);
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
          children: renderCountryInfo(),
        ),
      ),
    );
  }
}
