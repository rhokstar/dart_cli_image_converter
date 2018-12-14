import 'package:prompter_rhokstar/src/option.dart';
import 'package:prompter_rhokstar/src/terminal.dart';

// No need to recreate the Terminal, reuse the Terminal instead everytime ask() gets called. This used to be within the Prompter class. Marked 'final' that it should not be reassigned!
// Create one instance that's reused with const which is defined in terminal.dart
// Make private so that other people don't mess around intended or accidently.
final Terminal _terminal = const Terminal();

class Prompter {
  // Ask binary questions like yes or no
  // Receive the prompt arg as a string
  bool askBinary(String prompt) {
    // Use string interpolation so that we don't have to manually add (y/n)
    final input = _ask('$prompt (y/n)', []);

    // Checks if input contains a 'y' answer
    return input.contains('y');
  }

  // Ask the questions
  askMultiple(String prompt, List<Option> options) {
    final input = _ask(prompt, options);

    // Lists require integers
    // Parse the input and look up the index inside of options to look up the value
    // Catch any errors that may occur if input value is not 0 or 1
    try {
      return options[int.parse(input)].value;
    } catch(err) {
      // Repeats the ask until valid input is met
      return askMultiple(prompt, options);
    }
  }

  // Ask helper method
  String _ask(String prompt, List<Option> options) {
    _terminal.clearScreen();
    _terminal.printPrompt(prompt);
    _terminal.printOptions(options);
    return _terminal.collectInput();
  }
}