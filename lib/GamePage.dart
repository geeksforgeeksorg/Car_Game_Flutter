// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously, sized_box_for_whitespace

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'GameOver.dart';
import 'main.dart';
import 'package:flutter/foundation.dart';

// This is the main game page
class GamePage extends StatefulWidget {
  final String speed;

  const GamePage({Key? key, required this.speed}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  // Position of the background image
  double _positionY = 0.0;
  // Position of the opponent car
  double _posY = 0.0;
  // Random number generator
  Random random = Random();
  // X position of the opponent car
  double _posX = 150.0;
  // X position of the player car
  double _carPosX = 50;
  // Player's score
  int score = 0;

  // Animation controller for the game
  late AnimationController _controller;
  // Audio player for background music
  final AudioPlayer audioPlayer = AudioPlayer();
  late double height; // Screen height
  late double width; // Screen width

  // Initialize screen dimensions
  Future<void> _initScreenDimensions() async {
    await Future.delayed(Duration.zero);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initScreenDimensions();
    double speedFactor = 1.0;
    // Play background music
    audioPlayer.play(AssetSource("test.mp3"));
    // Set speed factor based on difficulty level
    switch (widget.speed) {
      case 'Easy':
        speedFactor = 0.5;
        break;
      case 'Medium':
        speedFactor = 1.0;
        break;
      case 'Hard':
        speedFactor = 2.0;
        break;
    }
    print("speed factor: $speedFactor");
    // Initialize animation controller with speed factor
    _controller = AnimationController(
      duration: Duration(seconds: (5 / speedFactor).round()),
      vsync: this,
    )..repeat(reverse: true);

    _controller.addListener(() {
      setState(() {
        // Move background image
        _positionY += height * 0.019;
        // Move opponent car
        _posY += height * 0.010;

        // Reset background position if it goes out of bounds
        if (_positionY > height * 0.066) {
          _positionY = 0.0;
        }

        // Reset opponent car position if it goes out of bounds
        if (_posY > height * 0.864) {
          _posY = 0.0;
          // Randomize opponent car position
          _posX = random.nextDouble() + random.nextInt(250);
          // Increase score
          score += 1;
        }

        // Check for collision
        if (height * 0.465 < _posY ||
            _carPosX < width * 0.0277 ||
            _carPosX > width * 0.638) {
          print('y crossover');

          // Check if player car collides with opponent car or goes out of bounds
          if ((_carPosX + width * 0.083) > (_posX - width * 0.066) &&
                  (_carPosX - width * 0.083) < (_posX + width * 0.0611) ||
              _carPosX < width * 0.0277 ||
              _carPosX > width * 0.638) {
            print(_carPosX);
            // End game if collision occurs
            gameOver();
            _posY = 0.0;
          }
        }
      });
    });
  }

  // Function to handle game over
  void gameOver() {
    _posY = 0.0;
    _positionY = 0.0;
    // Pause background music
    audioPlayer.pause();
    // Navigate to game over screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameOver(score)),
    );
  }

  // Function to restart the game
  void gameToStart() {
    _posY = 0.0;
    _positionY = 0.0;
    // Navigate to main screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyApp(),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose animation controller
    _controller.dispose();
    // Dispose audio player
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: (kIsWeb) ? 0 : height * 0.0930,
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 28,
        actions: [
          Text(
            'SCORE:' + score.toString(),
            style: TextStyle(
              fontSize: width * 0.051,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
              width: width * 2.2,
              // Background image
              child: Image.asset('assets/roadimg.jpg')),
          // Moving background image
          AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            // Move background image based on position Y
            transform: Matrix4.translationValues(0.0, _positionY, 0.0),
            child: Container(
                width: width * 2.2,
                // Moving background image
                child: Image.asset('assets/roadimg.jpg')),
          ),
          Hero(
            tag: 'car_opponent',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 10),
              // Move opponent car based on position Y and X
              transform: Matrix4.translationValues(_posX, _posY, 0.0),
              child: Container(
                  width: width * 0.333,
                  height: height * 0.1728,
                  // Opponent car
                  child: Image.asset('assets/caroppc.png')),
            ),
          ),
          Hero(
            tag: 'car_player',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 10),
              transform: Matrix4.translationValues(_carPosX, width + 75, 0.0),
              child: Container(
                  width: width * 0.333,
                  height: height * 0.2260,
                  // Player car
                  child: Image.asset('assets/newcar.png')),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Column(
              children: [
                Container(
                    width: width * 2.5,
                    // Black background
                    child: Image.asset('assets/black_bg.png')),
              ],
            ),
          ),
          // Gesture detector to handle player car movement
          // Move player car to the left or right based on tap position on the screen
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              // Get tap position on the screen and move player car accordingly
              double X = details.globalPosition.dx;
              double y = details.globalPosition.dy;
              print('X:$_carPosX,Y:$y');
              if (X > (width) * 0.52) {
                // Move player car to the right
                _carPosX += (width) * 0.063;
              } else if (X < (width) * 0.52) {
                // Move player car to the left
                _carPosX -= (width) * 0.063;
              }
            },
          ),
        ],
      ),
    );
  }
}
