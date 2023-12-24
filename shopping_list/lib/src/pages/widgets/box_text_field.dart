import 'package:flutter/material.dart';

class BoxTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validatorFunction;
  final int? maxLines;
  final TextInputType keyboardType;

  const BoxTextField(
      {super.key,
      this.hintText,
      this.validatorFunction,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (pointDownEvent) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
      validator: validatorFunction,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}
