
// MyHomePage class which is a StatelessWidget
import 'package:flutter/material.dart';
import 'package:geeks_for_geeks/selectModePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // Get screen height
    double width = MediaQuery.of(context).size.width; // Get screen width
    return Scaffold(
      backgroundColor: Colors.black, // Background color of the scaffold
      appBar: AppBar(
        title: Text(
          ' CAR RACE', // App bar title
          textAlign: TextAlign.center, // Center align the text
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: width * 0.076, // Responsive font size
            fontWeight: FontWeight.bold,
            letterSpacing: width * 0.051, // Letter spacing
          ),
        ),
        backgroundColor: Colors.amberAccent,
        toolbarHeight: width * 0.127, // Responsive toolbar height
      ),
      body: Stack(
        children: [
          Container(
              width: width * 5, // Set container width
              child: Image.asset('assets/roadimg.jpg')), // Background image
          Positioned(
            top: height * 0.53, // Position from top
            left: width * 0.30, // Position from left
            child: Container(
                width: width * 0.416, // Set container width
                child: Image.asset('assets/newcar.png')), // Car image
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SelectModePage()), // Navigate to SelectModePage
                );
              },
              child: Text(
                'TAP TO START',
                style: TextStyle(
                  fontSize: (height * 0.03), // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
