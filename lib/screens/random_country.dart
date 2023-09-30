import 'package:flutter/material.dart';

class RandomCountry extends StatefulWidget {
  const RandomCountry({super.key});

  @override
  State<RandomCountry> createState() => _RandomCountryState();
}

class _RandomCountryState extends State<RandomCountry> {
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
