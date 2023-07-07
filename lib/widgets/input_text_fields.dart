import 'package:flutter/material.dart';

class InputTextFields extends StatelessWidget {
  const InputTextFields({
    super.key,
    required this.hinttext,
    required this.textEditingController,
    required this.textInputType,
    required this.isPass,
    this.icon,
  });
  final String hinttext;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPass;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor:  const Color.fromARGB(63, 158, 158, 158),
        prefixIcon: icon,
        contentPadding: const EdgeInsets.all(21.0),
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
