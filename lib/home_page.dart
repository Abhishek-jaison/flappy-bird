import 'dart:async';

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

  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  void startGame() {
    gamehasstarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gamehasstarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (gamehasstarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0, birdYaxis),
                duration: Duration(milliseconds: 0),
                color: Colors.blue,
                child: MyBird(),
              ),
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
                    '0',
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
                    '10',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ],
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
