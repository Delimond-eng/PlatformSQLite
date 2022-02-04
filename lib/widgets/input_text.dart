import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String errorText;
  final String expandedLabel;
  final TextEditingController controller;
  final TextInputType inputType;

  const InputField({
    this.icon,
    this.hintText,
    this.errorText,
    this.expandedLabel,
    this.controller,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        } else {
          return null;
        }
      },
      controller: controller,
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: expandedLabel,
        hintText: '$hintText...',
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12.0,
        ),
        counterText: '',
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
          size: 16.0,
        ),
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue[900],
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
