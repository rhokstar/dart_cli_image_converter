// Responsible for printing to the terminal

import 'dart:io';
import 'package:prompter_rhokstar/src/option.dart';

class Terminal {
  // Define terminal as a const constructor, which will allow to create only one instance and reuse of Terminal.
  const Terminal();

  void printPrompt(String prompt) {
    stdout.writeln(prompt);
  }

  // Loop through the labels
  void printOptions(List<Option> options) {

  // Turn into a Map so we can get access to the index.
  options.asMap().forEach((index, option) {
    stdout.writeln('[$index] - ${option.label}');
  });
    

    // stdout.writeln('Choose The Red Pill or The Blue pill...\n');
    stdout.write('>');
  }

  // Take in keyboard input
  String collectInput() {
    return stdin.readLineSync();
  }

  void clearScreen() {
    if(Platform.isWindows) {
      // Clear the window
      stdout.write('\x1B[2J\x1B[0f');
    } else {
      stdout.write('\x1B[2J\x1B[3J\x1B[H');
    }
  }
}