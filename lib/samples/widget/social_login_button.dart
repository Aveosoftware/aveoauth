import 'package:aveoauth/samples/sample.dart';

class CustomLoginButtonSample extends Sample {

  CustomLoginButtonSample(
    String path,
) : super(path);

  String get import => '''
import 'package:flutter/material.dart';
''';

  @override
  String get content => '''$import

class CustomButton extends StatelessWidget {
  final String logoUrl;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final bool isLabelVisible;
  final double buttonWidth;
  final Function onPressed;
  final Size iconSize;
  const CustomButton({
    Key? key,
    required this.logoUrl,
    required this.text,
    this.textColor = Colors.black54,
    this.backgroundColor = Colors.white,
    this.isLabelVisible = true,
    this.buttonWidth = 200.0,
    required this.onPressed,
    this.iconSize = const Size(30.0, 30.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: isLabelVisible ? buttonWidth : iconSize.width + 10.0,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                logoUrl,
                height: iconSize.height,
                width: iconSize.width,
              ),
              if (isLabelVisible)
                Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
''';
}
