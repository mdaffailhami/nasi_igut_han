import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.labelText,
    this.obscureText = false,
    this.suffix,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.initialValue,
    this.keyboardType,
    this.inputFormatter,
  });

  final String? labelText;
  final bool obscureText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 45,
      width: 300,
      child: TextFormField(
        maxLines: null,
        obscureText: obscureText,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: initialValue,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          suffix: suffix,
          suffixIcon: suffixIcon,
          isDense: true,
        ),
      ),
    );
  }
}
