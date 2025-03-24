// ignore_for_file: camel_case_types, duplicate_ignore, must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:geeks_for_geeks/GamePage.dart';
import 'package:geeks_for_geeks/main.dart';

// This class represents the Game Over screen
class GameOver extends StatefulWidget {
  int? scoreShow;

  // Constructor to initialize the score
  GameOver(int score) {
    scoreShow = score;
  }

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '   GAME OVER',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: width * 0.076,
            fontWeight: FontWeight.bold,
            letterSpacing: width * 0.0255,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
        toolbarHeight: width * 0.127,
      ),
      body: Stack(
        children: [
          const Padding(padding: EdgeInsets.all(0)),
          // Display the background image
          Container(
              width: width * 2.5, child: Image.asset('assets/roadimg.jpg')),
          // Position the car image
          Positioned(
            top: height * 0.53,
            left: width * 0.30,
            child: Container(
                width: width * 0.41, child: Image.asset('assets/newcar.png')),
          )
        ],
      ),
      floatingActionButton: Column(
        children: [
          Padding(padding: EdgeInsets.all(width * 0.178)),
          // Display the score
          Text(
            '     SCORE:${widget.scoreShow}',
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.25, vertical: height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                // Button to restart the game
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GamePage(speed: ''),
                      ),
                    );
                  },
                  child:  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        '  RESTART',
                        style: TextStyle(
                          fontSize: height * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
    
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                // Button to go back to the home screen
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        '  HOME',
                        style: TextStyle(
                          fontSize: height * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
