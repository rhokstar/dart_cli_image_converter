// Import the library that was uploaded to Dart Pub
import 'package:prompter_rhokstar/prompter_rhokstar.dart';
import 'dart:io';
import 'package:image_converter_rhokstar/src/converter.dart';

void main() {
  final prompter = new Prompter();

  final choice = prompter.askBinary('Do you want to convert an image?');

  if (!choice) {
    exit(0);
  }

  final format =
      prompter.askMultiple('Select file format:', buildFormatOptions());
  final selectedFile = prompter.askMultiple('Select an image to convert:', buildFileOptions());
  final newPath = convertImage(selectedFile, format);

  final shouldOpen = prompter.askBinary('Open the image?');

  if(shouldOpen) {
    Process.run('open', [newPath]);
  }
}

List<Option> buildFormatOptions() {
  return [
    new Option('Convert to JPEG', 'jpeg'),
    new Option('Convert to PNG', 'png')
  ];
}

List<Option> buildFileOptions() {
  // Get a reference to the current working directory
  return Directory.current
      // Find all files and folders in the directory
      .listSync()
      // Look through the list and return only images, check entities list
      // Use 'where' instead of 'forEach'. where creates a new list of items that passed a criteria.
      .where((entity) {
    // Return files only with *.jpg or *.png
    return FileSystemEntity.isFileSync(entity.path) &&
        entity.path.contains(new RegExp(r'\.(png|jpg|jpeg)'));
  }).map((entity) {
    // Get the filename by splitting the path, then extract from last '/' or '\'
    final filename = entity.path.split(Platform.pathSeparator).last;
    return new Option(filename, entity);
  }).toList();

  // TODO: Take all the images and create an option object out of each
}
