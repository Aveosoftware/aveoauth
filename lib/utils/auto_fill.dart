part of '../aveoauth.dart';

registerAutofillListen() {
  SmsAutoFill().listenForCode;
}

Future<String> generateAutoFillSignature() async {
  return await SmsAutoFill().getAppSignature;
}

unRegisterAutofillListen() {
  SmsAutoFill().unregisterListener();
}

class PinField extends StatefulWidget {
  final String? currentCode;
  final TextEditingController controller;
  final dynamic Function(String?)? onCodeChanged;
  const PinField(
      {Key? key,
      this.currentCode,
      required this.controller,
      this.onCodeChanged})
      : super(key: key);

  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  String? currentCode;
  @override
  void initState() {
    currentCode = widget.currentCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PinFieldAutoFill(
        currentCode: currentCode,
        controller: widget.controller,
        onCodeChanged: (code) {
          setState(() {
            currentCode = code;
          });
          widget.onCodeChanged;
        },
        decoration: UnderlineDecoration(
            lineHeight: 2,
            lineStrokeCap: StrokeCap.square,
            bgColorBuilder: PinListenColorBuilder(
                Colors.green.shade200, Colors.grey.shade200),
            colorBuilder: const FixedColorBuilder(Colors.transparent),
            textStyle: const TextStyle(
                color:
                    Colors.black)) // prefill with a code//code changed callback
        );
  }
}
