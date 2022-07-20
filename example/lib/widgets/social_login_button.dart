import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String logoUrl;
  final String text;
  final Function onPressed;
  const CustomButton(
      {Key? key,
      required this.logoUrl,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              logoUrl,
              height: 30,
              width: 30,
            ),
            TextButton(
              onPressed: () {
                onPressed();
              },
              child: Text(
                text,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
