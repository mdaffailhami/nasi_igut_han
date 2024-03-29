import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/other/responsive_builder.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    return MyResponsiveBuilder((context, isSmall, isMedium, isLarge) {
      if (isSmall || isMedium) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: MemoryImage(base64Decode(settings.logo)),
            ),
            // const SizedBox(height: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  settings.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 36, color: Colors.white),
                ),
                SelectableText(
                  settings.quote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent,
              backgroundImage: MemoryImage(base64Decode(settings.logo)),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  settings.title,
                  style: const TextStyle(fontSize: 50, color: Colors.white),
                ),
                SelectableText(
                  settings.quote,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        );
      }
    });
  }
}
