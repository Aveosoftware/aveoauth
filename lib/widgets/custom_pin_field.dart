part of '../aveoauth.dart';

class CustomPinField extends StatelessWidget {
  final BuildContext context;
  final void Function(String) onChanged;
  final TextEditingController? textEditingController;
  final StreamController<ErrorAnimationType>? errorController;
  final void Function(String)? onCompleted;
  final bool Function(String?)? beforeTextPaste;
  const CustomPinField(
      {super.key,
      required this.context,
      required this.onChanged,
      this.textEditingController,
      this.errorController,
      this.onCompleted,
      this.beforeTextPaste});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        selectedColor: Theme.of(context).colorScheme.primary,
        selectedFillColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Colors.grey,
        inactiveFillColor: Colors.grey,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      errorAnimationController: errorController,
      controller: textEditingController,
      onCompleted: onCompleted,
      onChanged: onChanged,
      beforeTextPaste: beforeTextPaste,
    );
  }
}
