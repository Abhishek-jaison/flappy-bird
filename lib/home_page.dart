import 'dart:async';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialheight = birdYaxis;
  bool gamehasstarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;
  int bestScore = 0;

  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  void startGame() {
    gamehasstarted = true;
    score = 0;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight - height;
      });

      // Move barriers and check for collision
      setState(() {
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });

      // Increment score when barriers pass the bird
      if (barrierXone < -1.1) {
        barrierXone += 3.5;
        score++;
      }
      if (barrierXtwo < -1.1) {
        barrierXtwo += 3.5;
        score++;
      }

      // Check for collision
      if (birdYaxis > 1 ||
          birdYaxis < -1 ||
          ((barrierXone > -0.2 && barrierXone < 0.2) && (birdYaxis < -0.3 || birdYaxis > 0.3)) ||
          ((barrierXtwo > -0.2 && barrierXtwo < 0.2) && (birdYaxis < -0.6 || birdYaxis > 0.6))) {
        timer.cancel();
        gamehasstarted = false;
        if (score > bestScore) {
          bestScore = score;
        }
        _showGameOverDialog();
      }
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Game Over")),
          
          actions: <Widget>[
            TextButton(
              child: Center(child: Text("Restart")),
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      birdYaxis = 0;
      time = 0;
      height = 0;
      initialheight = birdYaxis;
      barrierXone = 1;
      barrierXtwo = barrierXone + 1.5;
      gamehasstarted = false;
      score = 0;
    });
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gamehasstarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.1),
                    child: gamehasstarted
                        ? Text('')
                        : Text(
                            'T A P TO P L A Y',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXone, 1.1),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXone, -1.1),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXtwo, 1.1),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(barrierXtwo, -1.1),
                    child: MyBarrier(
                      size: 250.0,
                    ),
                  ),
                ],
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SCORE',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '$score',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BEST',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '$bestScore',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
