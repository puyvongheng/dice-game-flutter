// lib/main.dart
import 'package:flutter/material.dart';
import 'dart:async'; // Import Timer
import 'dart:math'; // Import Random
import 'dice.dart'; // Import Dice class

void main() {
  runApp(const DiceGame());
}

class DiceGame extends StatelessWidget {
  const DiceGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceGameScreen(),
    );
  }
}

class DiceGameScreen extends StatefulWidget {
  const DiceGameScreen({super.key});

  @override
  _DiceGameScreenState createState() => _DiceGameScreenState();
}

class _DiceGameScreenState extends State<DiceGameScreen> {
  int diceNumber = 1;
  bool isRolling = false;

  // Function to start the 20 seconds random dice roll
  void startRandomRoll() {
    setState(() {
      isRolling = true;
    });

    // Timer for 20 seconds
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // If 20 seconds have passed, stop the timer
      if (timer.tick >= 100) {
        // 20 seconds / 0.2 seconds interval = 100 ticks
        timer.cancel();
        setState(() {
          isRolling = false; // Stop rolling
        });
      } else {
        // Update the dice number every 200 milliseconds
        setState(() {
          diceNumber = Random().nextInt(6) + 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Game'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedSwitcher for smooth transitions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return RotationTransition(
                        turns: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(animation),
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.5, end: 1.0)
                              .animate(animation),
                          child:
                              FadeTransition(opacity: animation, child: child),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/Layer $diceNumber.png',
                      key: ValueKey<int>(diceNumber), // Key to detect changes
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: isRolling
                  ? null
                  : startRandomRoll, // Disable button while rolling
              child: Text(isRolling ? 'Rolling...' : 'Start Game (10s)'),
            ),
          ],
        ),
      ),
    );
  }
}
