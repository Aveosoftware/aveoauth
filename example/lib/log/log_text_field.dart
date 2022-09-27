import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Function(String) onFiledSubmitted;
  final TextEditingController fieldController;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int textLines;
  final bool isOptionalField;
  final String? emptyFieldMessage;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  const CustomTextField(
      {Key? key,
      this.textLines = 1,
      required this.onFiledSubmitted,
      required this.fieldController,
      required this.focusNode,
      this.nextFocusNode,
      this.validator,
      this.onChanged,
      this.obscureText = false,
      this.isOptionalField = false,
      this.emptyFieldMessage,
      this.hintText,
      this.labelText,
      this.keyboardType})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;
  @override
  void initState() {
    _isObscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, top: 15, bottom: 0),
      child: TextFormField(
        validator: widget.validator,
        autocorrect: true,
        onFieldSubmitted: (v) {
          widget.onFiledSubmitted(v);
          if (widget.nextFocusNode != null) {
            FocusScope.of(context).requestFocus(widget.nextFocusNode);
          }
        },
        keyboardType: widget.keyboardType,
        obscureText: _isObscure,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          suffixIcon: Visibility(
            visible: widget.obscureText,
            child: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        cursorWidth: 1.0,
        cursorColor: Theme.of(context).colorScheme.secondary,
        onChanged: widget.onChanged,
        controller: widget.fieldController,
        minLines: widget.textLines,
        maxLines: widget.textLines,
      ),
    );
  }
}
