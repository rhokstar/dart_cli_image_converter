// Only imports code relevant developers should use only.
import 'package:prompter_rhokstar/prompter_rhokstar.dart';

void main() {
  final options = [
    new Option('The Red Pill', '#f00'),
    new Option('The Blue Pill', '#00f')
  ];

  // Create new instance of Prompter
  final prompter = new Prompter();

  String pillColor = prompter.askMultiple('Morpheus asks you... select a pill:\n', options);

  bool answer = prompter.askBinary('Do you like Dart?');

  print(pillColor);
  print(answer);
}