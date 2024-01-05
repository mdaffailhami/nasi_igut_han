import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:nasi_igut_han/pages/home_page.dart';
import 'package:nasi_igut_han/pages/sign_in_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
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
      initialRoute: MyHomePage.route,
      routes: {
        MyHomePage.route: (_) => const MyHomePage(),
        MySignInPage.route: (_) => const MySignInPage(),
      },
    );
  }
}
