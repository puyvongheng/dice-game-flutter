// lib/dice.dart
import 'dart:math';

class Dice {
  static int rollDice() {
    return Random().nextInt(6) + 1; // Random number between 1-6
  }
}
