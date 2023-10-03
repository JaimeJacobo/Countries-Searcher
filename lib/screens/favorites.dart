import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Map<String, dynamic> userInfo = {};

  @override
  initState() {
    super.initState();
    User? currentUser = FirebaseAuth.instance.currentUser;

    searchDocumentByUID(currentUser?.uid).then((result) {
      setState(() {
        userInfo = result;
      });
      print(userInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'My favorite countries',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            renderFavoriteCountries()
          ],
        ),
      ),
    );
  }

  dynamic renderFavoriteCountries() {
    if (userInfo.isNotEmpty) {
      return Flexible(
        child: ListView.builder(
          itemCount: userInfo['favoriteCountries'].length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ListTile(
                leading:
                    Image.network(userInfo['favoriteCountries'][index]['flag']),
                title: Text(userInfo['favoriteCountries'][index]['name']),
              ),
            );
          },
        ),
      );
    } else {
      return const Text("Loading...");
    }
  }
}

dynamic searchDocumentByUID(String? uid) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await users.where('uid', isEqualTo: uid).get();

    if (querySnapshot.docs.isEmpty) {
      print('No document found with UID: $uid');
      return null;
    }

    return querySnapshot.docs[0].data();
  } catch (e) {
    print('Error searching for document: $e');
    return null;
  }
}
