import 'dart:developer';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int time = 0;
  String win = "";
  int turns = 0;
  bool draw = true;
  int XScore = 0;
  int OScore = 0;
  bool turn = true;
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Score Board",
                    style: (TextStyle(color: Colors.green, fontSize: 30)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Player X ",
                            style:
                                (TextStyle(color: Colors.green, fontSize: 25)),
                          ),
                          Text(
                            XScore.toString(),
                            style:
                                (TextStyle(color: Colors.green, fontSize: 25)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Player O ",
                            style:
                                (TextStyle(color: Colors.green, fontSize: 25)),
                          ),
                          Text(
                            OScore.toString(),
                            style:
                                (TextStyle(color: Colors.green, fontSize: 25)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (() => _singleTap(index)),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.amber,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("@Mihir Shah"),
                  TextButton(
                    onPressed: _NextGame,
                    child: Text("Reset Scores"),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void _singleTap(int index) {
    setState(
      () {
        if (turn && displayXO[index] == '') {
          displayXO[index] = 'X';
          turn = !turn;
          turns = turns + 1;
        } else if (!turn && displayXO[index] == '') {
          displayXO[index] = 'O';
          turn = !turn;
          turns = turns + 1;
        }

        _winner();
      },
    );
  }

  void _winner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      time += 1;
      win = displayXO[0];
      draw = false;
      _winDialogue("Winner is " + displayXO[0]);
    }
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      time += 1;
      win = displayXO[0];
      draw = false;
      _winDialogue("Winner is " + displayXO[0]);
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      time += 1;
      win = displayXO[0];
      draw = false;
      _winDialogue("Winner is " + displayXO[0]);
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      time += 1;
      win = displayXO[3];
      draw = false;
      _winDialogue("Winner is " + displayXO[3]);
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        time == 0 &&
        displayXO[6] != '') {
      time += 1;
      win = displayXO[6];
      draw = false;
      _winDialogue("Winner is " + displayXO[6]);
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        time == 0 &&
        displayXO[1] != '') {
      time += 1;
      win = displayXO[1];
      draw = false;
      _winDialogue("Winner is " + displayXO[1]);
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        time == 0 &&
        displayXO[2] != '') {
      time += 1;
      win = displayXO[2];
      draw = false;
      _winDialogue("Winner is " + displayXO[2]);
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        time == 0 &&
        displayXO[2] != '') {
      time += 1;
      _winDialogue("Winner is " + displayXO[2]);
      win = displayXO[2];
      draw = false;
    }
    time = 0;
    if (draw == true && turns >= 9) {
      _winDialogue("Game Draw");
    }
  }

  void _winDialogue(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          winner,
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text("Next Game"),
            onPressed: () {
              _NewGame();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

    if (win == 'X') {
      XScore += 1;
    } else if (win == "O") {
      OScore += 1;
    }
    turn = true;
  }

  void _NewGame() {
    setState(
      () {
        _ClearBoard();
        win = "";
        turns = 0;
        draw = true;
        time = 0;
        turn = true;
      },
    );
  }

  void _ClearBoard() {
    displayXO = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];
    turns = 0;
    turn = true;
  }

  void _NextGame() {
    setState(() {
      _ClearBoard();
      XScore = 0;
      OScore = 0;
      turn = true;
    });
  }
}
