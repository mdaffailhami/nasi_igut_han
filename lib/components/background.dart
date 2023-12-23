import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';

class MyBackground extends ConsumerWidget {
  const MyBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.memory(
            base64Decode(settings.background),
            fit: BoxFit.cover,
          ),
          const SizedBox(child: ColoredBox(color: Colors.black54)),
        ],
      ),
    );
  }
}
