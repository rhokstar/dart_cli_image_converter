import 'dart:io';
import 'package:image/image.dart';

// FileSystemEntity refences the files, not the content.
convertImage(FileSystemEntity selectedFile, String format) {
  // Tells Dart this is a file which allows methods for the File class
  final rawImage = (selectedFile as File).readAsBytesSync();
  final image = decodeImage(rawImage);

  var newImage;

  if(format == 'jpg') {
    newImage = encodeJpg(image);
  } else if (format == 'png') {
    newImage = encodePng(image);
  } else {
    print('Unsupported file type.');
  }

  // Save with the same filename before file extension.
  final newPath = replaceExtension(selectedFile.path, format);
  new File(newPath).writeAsBytesSync(newImage);

  return newPath;
}

// Replace the previous file extension with new file extension
String replaceExtension(String path, String newExtension) {
  // Use RegEx to figure out the extension
  return path.replaceAll(new RegExp(r'(png|jpg|jpeg)'), newExtension);
}