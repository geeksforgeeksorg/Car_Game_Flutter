// select_mode.dart
import 'package:flutter/material.dart';
import 'package:geeks_for_geeks/GamePage.dart';

class SelectModePage extends StatefulWidget {
  @override
  _SelectModePageState createState() => _SelectModePageState();
}

class _SelectModePageState extends State<SelectModePage> {
  // Default mode is set to 'Easy'
  String selectedMode = 'Easy';

  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Select Mode',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: width * 0.076,
            fontWeight: FontWeight.bold,
            letterSpacing: width * 0.0255,
          ),
        ),
        backgroundColor: Colors.amberAccent,
        toolbarHeight: width * 0.127,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
              width: width * 2.5, child: Image.asset('assets/roadimg.jpg')),
          // Car image positioned on the screen
          Positioned(
            top: height * 0.53,
            left: width * 0.30,
            child: Container(
                width: width * 0.416, child: Image.asset('assets/newcar.png')),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.192),
                // Title text
                Text(
                  'Select Speed Level',
                  style: TextStyle(
                    fontSize: width * 0.076,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.038),
                // Row of speed buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSpeedButton('Easy', width, height),
                    SizedBox(
                      width: width * 0.0255,
                    ),
                    buildSpeedButton('Medium', width, height),
                    SizedBox(
                      width: width * 0.0255,
                    ),
                    buildSpeedButton('Hard', width, height),
                  ],
                ),
                SizedBox(height: height * 0.0384),
                // Start Game button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(speed: selectedMode),
                      ),
                    );
                  },
                  child: Text(
                    'Start Game',
                    style:
                        TextStyle(fontSize: width * 0.051, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build speed buttons
  Widget buildSpeedButton(String mode, double width, double height) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedMode = mode;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedMode == mode ? Colors.amberAccent : Colors.grey,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.051, vertical: height * 0.0128),
      ),
      child: Text(
        mode,
        style: TextStyle(fontSize: width * 0.045, color: Colors.black),
      ),
    );
  }
}
