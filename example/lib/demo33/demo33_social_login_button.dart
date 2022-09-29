import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String logoUrl;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final bool isLabelVisible;
  final bool isImageVisible;
  final double? buttonWidth;
  final double? buttonHeight;
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
    this.isImageVisible = true,
    this.buttonHeight,
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
          height: buttonHeight,
          width: isLabelVisible ? buttonWidth : iconSize.width + 10.0,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: isImageVisible,
                child: Image.network(
                  logoUrl,
                  height: iconSize.height,
                  width: iconSize.width,
                ),
              ),
              Visibility(
                visible: isImageVisible && isLabelVisible,
                child: const SizedBox(
                  width: 20,
                ),
              ),
              Visibility(
                visible: isLabelVisible,
                child: Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
