import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/other/responsive_builder.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';

class MyFooter extends ConsumerWidget {
  const MyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    return SizedBox(
      width: double.infinity,
      // height: 200,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 28),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(1.5), // Border width
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: MyResponsiveBuilder(
                      (context, isSmall, isMedium, isLarge) {
                    double width;
                    if (isSmall) {
                      width = MediaQuery.of(context).size.width * 0.8;
                    } else if (isMedium) {
                      width = MediaQuery.of(context).size.width * 0.6;
                    } else {
                      width = MediaQuery.of(context).size.width * 0.4;
                    }

                    return Image.asset(
                      'assets/map.jpeg',
                      fit: BoxFit.cover,
                      height: 180,
                      width: width,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 14),
              SelectableText(
                '| © 2024 ${settings.title} - All Rights Reserved |',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
