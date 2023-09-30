import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/random_country.dart';
import 'screens/favorites.dart';
import 'screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  int _navbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Home(),
        ),
        Container(
          alignment: Alignment.center,
          child: const RandomCountry(),
        ),
        Container(
          alignment: Alignment.center,
          child: const Favorites(),
        ),
        Container(
          alignment: Alignment.center,
          child: const Profile(),
        ),
      ][_navbarIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _navbarIndex = index;
          });
        },
        selectedIndex: _navbarIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shuffle),
            label: 'Random Country',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.flag),
            icon: Icon(Icons.outlined_flag),
            label: 'Favorite Flags',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
