import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      NavigatorState navigatorState = Navigator.of(context);
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('users');
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        await users.doc(userCredential.user!.uid).set({
                          'email': _emailController.text,
                          'favoriteCountries': [],
                        });
                        bool result = await _showSuccessSnackbar();
                        if (result) {
                          navigatorState.pushNamed('/login');
                        }
                      } catch (error) {
                        print('Failed to sign up');
                        print(error.toString());
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      NavigatorState navigatorState = Navigator.of(context);
                      navigatorState.pushNamed('/login');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blueGrey), // Set the background color here
                    ),
                    child: const Text('Go to Log In'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showSuccessSnackbar() async {
    Completer<bool> completer = Completer<bool>();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: const <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(width: 10),
          Text(
            'Sign up successfully',
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    ));

    // Run something after the Snackbar duration ends
    Duration duration = const Duration(seconds: 2);
    await Future.delayed(duration, () {
      completer.complete(true);
    });

    return completer.future; // Return the Future<bool>
  }
}
