import 'dart:convert';

import 'package:flutter/material.dart';

class MySocmedFormField extends StatelessWidget {
  const MySocmedFormField({
    super.key,
    required this.icon,
    required this.initialValue,
    required this.onIconPressed,
    required this.onTextFieldChanged,
  });

  final String icon;
  final String? initialValue;
  final void Function()? onIconPressed;
  final void Function(String value)? onTextFieldChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: InkWell(
              onTap: onIconPressed,
              child: Stack(
                children: [
                  Image.memory(
                    base64Decode(icon),
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 45,
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      color: Colors.black45,
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              onChanged: onTextFieldChanged,
              decoration: const InputDecoration(
                label: Text('Link'),
                // suffixIcon: IconButton(
                //   onPressed: () {},
                //   icon: const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
