// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:geeks_for_geeks/HomePage.dart';

// Main function to run the app
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// State class for MyApp
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Theme color scheme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        // Use Material 3 design
        useMaterial3: true,
      ),
      // Home page of the app
      home: const HomePage(),
    );
  }
}
