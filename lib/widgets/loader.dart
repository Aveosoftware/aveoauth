import 'package:flutter/material.dart';

showLoader(BuildContext context) {
  var alert = Center(
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(color: Colors.transparent),
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

hideLoader(BuildContext context) {
  Navigator.pop(context);
}
