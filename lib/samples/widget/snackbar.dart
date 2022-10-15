import 'package:aveoauth/samples/sample.dart';

class CustomSnackBarSample extends Sample {
  CustomSnackBarSample(
    String path,
  ) : super(path);

  String get import => '''
import 'package:flutter/material.dart';
''';

  @override
  String get content => '''$import

snackBar(message, context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
''';
}
