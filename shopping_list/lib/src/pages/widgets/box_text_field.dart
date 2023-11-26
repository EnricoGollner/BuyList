import 'package:flutter/material.dart';

class BoxTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validatorFunction;
  final int? maxLines;

  const BoxTextField(
      {super.key,
      this.hintText,
      this.validatorFunction,
      required this.controller,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      onTapOutside: (pointDownEvent) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      validator: validatorFunction,
      maxLines: maxLines,
    );
  }
}
