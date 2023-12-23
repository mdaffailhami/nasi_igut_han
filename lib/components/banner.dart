import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/profile.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';

class MyBanner extends ConsumerWidget {
  const MyBanner({Key? key}) : super(key: key);

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.memory(base64Decode(settings.banner), fit: BoxFit.cover),
        const SizedBox(child: ColoredBox(color: Colors.black54)),
        const Padding(
          padding: EdgeInsets.only(top: 26),
          child: MyProfile(),
        ),
      ],
    );
  }
}
