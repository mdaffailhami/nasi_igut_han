import 'package:flutter/material.dart';

class MyAdminHomePage extends StatelessWidget {
  const MyAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pop(context);
      },
    );
    return const Placeholder();
  }
}
