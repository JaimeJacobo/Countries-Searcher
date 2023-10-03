import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

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
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Text(
            selectedCountry["name"]["common"],
            style: const TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.blue,
            ),
          ),
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
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              try {
                User? currentUser = FirebaseAuth.instance.currentUser;
                CollectionReference users =
                    FirebaseFirestore.instance.collection('users');

                if (currentUser != null) {
                  await users.doc(currentUser.uid).update({
                    'favoriteCountries': FieldValue.arrayUnion([
                      {
                        "name": selectedCountry["name"]["common"],
                        "flag": selectedCountry["flags"]["png"],
                      }
                    ])
                  });
                }
                print('Country added correctly');
              } catch (err) {
                print('Error registering favorite country');
                print(err);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green), // Set the background color here
            ),
            child: const Text('Add to Favorites'),
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
