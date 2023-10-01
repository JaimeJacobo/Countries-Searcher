import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is the PROFILE Page',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  NavigatorState navigatorState = Navigator.of(context);
                  try {
                    await FirebaseAuth.instance.signOut();
                    print(FirebaseAuth.instance.currentUser);
                    navigatorState.pushNamed('/login');
                  } catch (err) {
                    print('Error in log out');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blueGrey), // Set the background color here
                ),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
