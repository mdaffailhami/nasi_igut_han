import 'package:flutter/material.dart';
import 'package:nasi_igut_han/pages/home_page.dart';
import 'package:nasi_igut_han/pages/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nasi Igut Han',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffb42d)),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
