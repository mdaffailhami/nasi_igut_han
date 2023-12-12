import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        obscureText: obscureText,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
