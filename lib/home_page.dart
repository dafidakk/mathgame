import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathgame/util/my_button.dart';
import 'package:mathgame/pages/multiply_page.dart';
import 'package:mathgame/pages/subtraction_page.dart';
import 'package:mathgame/util/result_message.dart';
import 'package:flutter/services.dart';

import 'const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',
  ];

  int lives = 5;

  bool gameOver = false;

  // number A, number B

  int numberA = 1;
  int numberB = 1;

  // user answer

  String userAnswer = '';

  // user tapped a button

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        // calculate if user is correct or incorrect
        checkResult();
      } else if (button == 'C') {
        // clear rhe input
        userAnswer = '';
      } else if (button == 'DEL') {
        // delete the last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        // maximum of 3 numbers can be inputted
        userAnswer += button;
      }
    });
  }

  // check if user correct or not

  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
                icon: Icons.arrow_forward,
                message: 'Correct!',
                onTap: goToNextQuestion);
          });
    } else {
      if (lives > 0) {
        lives -= 1;
        if (lives <= 0) {
          gameOver = true;
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.deepPurple,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        label: Text(
                          'Exit App',
                          style: whiteTextStyle,
                        ),
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  ),
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return ResultMessage(
                    icon: Icons.rotate_left,
                    message: 'Sorry try again!',
                    onTap: goBackToQuestion);
              });
        }
      }
    }
  }

  //create random numbers
  var randomNumber = Random();

  // GO TO NEXT QUESTION
  void goToNextQuestion() {
    // dissmiss alert dialog
    Navigator.of(context).pop();
    // reset values
    setState(() {
      userAnswer = '';
    });
    // create a new question
    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
  }

  // GO BACK TO QUESTION

  void goBackToQuestion() {
    // dissmiss alert dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple[100],
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        'Operation Menu',
                        style: whiteTextStyle,
                      ),
                      Icon(Icons.gas_meter_outlined),
                    ],
                  ),
                ),
              ),
              ListTile(
                // ignore: prefer_const_constructors
                leading: Icon(
                  Icons.remove_circle_outline_sharp,
                ),
                title: Text(
                  'Subtraction Page',
                  style: whiteTextStyle_2,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: ((context) => SubtractionPage()),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.multiline_chart,
                ),
                title: Text(
                  'Multiply Page',
                  style: whiteTextStyle_2,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => MultiplyPage()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          // level progress, playerr needs 5 correct answers in a row to proceed to next level
          Container(
            height: 100,
            color: Colors.deepPurple,
            child: SizedBox(
              height: 20,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: lives,
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.favorite,
                    color: Colors.green.shade400,
                    size: 40,
                  );
                },
              ),
            ),
          ),
          // question
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // question
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    numberA.toString() + ' + ' + numberB.toString() + ' =',
                    style: whiteTextStyle,
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[400],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        userAnswer,
                        style: whiteTextStyle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // number pad
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                itemCount: numberPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return MyButton(
                    child: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
