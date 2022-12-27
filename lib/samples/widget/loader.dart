import 'package:aveoauth/samples/sample.dart';

class CustomLoaderSample extends Sample {
  CustomLoaderSample(
    String path,
  ) : super(path);

  String get import => '''
import 'package:flutter/material.dart';
''';

  @override
  String get content => '''$import

showLoaderDialog(BuildContext context) {
  var alert = Center(
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          width: 100.0,
          height: 100.0,
          child: const Padding(
            padding: EdgeInsets.all(30.0),
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )));
  showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      });
}

hideLoaderDialog(BuildContext context) {
  Navigator.pop(context);
}

''';
}
