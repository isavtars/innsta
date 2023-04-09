import 'package:flutter/material.dart';

class InputTextFeilds extends StatelessWidget {
  const InputTextFeilds({
    super.key,
    required this.hinttext,
    required this.textEditingController,
    required this.textInputType,
    required this.isPass,
  });
  final String hinttext;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(21.0),
        hintText: hinttext,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
