import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/admin.dart';
import 'package:nasi_igut_han/pages/home_page.dart';
import 'package:nasi_igut_han/pages/sign_in_page.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';

void main() {
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
      home: Consumer(builder: (context, ref, child) {
        ref.read(adminProvider.notifier).signIn(
            Admin(email: 'ilhamvocalovi@gmail.com', password: '12345678'));
        return const MyHomePage();
      }),
    );
  }
}
