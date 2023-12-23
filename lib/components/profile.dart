import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 67,
          backgroundColor: Colors.transparent,
          backgroundImage: MemoryImage(base64Decode(settings.logo)),
        ),
        const SizedBox(height: 4),
        Text(
          settings.title,
          style: const TextStyle(fontSize: 32, color: Colors.white),
        ),
        // const SizedBox(height: 2),
        // RichText(
        //   text: TextSpan(
        //     style:
        //         Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
        //     children: [
        //       const TextSpan(text: '<'),
        //       TextSpan(
        //           text: 'code',
        //           style: TextStyle(
        //               color: Theme.of(context).colorScheme.secondaryContainer)),
        //       const TextSpan(text: '> Programmer'),
        //       TextSpan(
        //           text: ' | ',
        //           style: TextStyle(
        //               color: Theme.of(context).colorScheme.secondaryContainer)),
        //       const TextSpan(text: 'Developer </'),
        //       TextSpan(
        //           text: 'code',
        //           style: TextStyle(
        //               color: Theme.of(context).colorScheme.secondaryContainer)),
        //       const TextSpan(text: '>'),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
