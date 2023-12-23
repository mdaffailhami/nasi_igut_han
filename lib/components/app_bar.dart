import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/banner.dart';
import 'package:nasi_igut_han/components/contact_us_form.dart';
import 'package:nasi_igut_han/components/faq.dart';
import 'package:nasi_igut_han/components/products.dart';
import 'package:nasi_igut_han/components/settings_form.dart';
import 'package:nasi_igut_han/components/sign_out_dialog.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/other/responsive_builder.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';
import 'package:nasi_igut_han/widgets/navigation_button.dart';

class MyAppBar extends ConsumerWidget {
  const MyAppBar({super.key, required this.isShrink});

  final bool isShrink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(adminProvider);
    final settings = ref.watch(settingsProvider) as Settings;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 350,
      flexibleSpace: const FlexibleSpaceBar(
        background: MyBanner(),
      ),
      actions: admin == null
          ? null
          : [
              IconButton(
                tooltip: 'Setelan',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const MySettingsForm(),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: isShrink ? Colors.black : Colors.white,
                ),
              ),
              IconButton(
                tooltip: 'Keluar',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const MySignOutDialog(),
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: isShrink ? Colors.black : Colors.white,
                ),
              ),
            ],
      leading: MyResponsiveBuilder((_, isSmall, isMedium, isLarge) {
        if (isSmall) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon:
                Icon(Icons.menu, color: isShrink ? Colors.black : Colors.white),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
      centerTitle: true,
      title: MyResponsiveBuilder(
        (_, isSmall, isMedium, isLarge) {
          if (isSmall) {
            return MyNavigationButton(
              componentKey: MyBanner.componentKey,
              child: isShrink
                  ? const CircleAvatar(
                      radius: 19,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/profile.png'),
                    )
                  : Text(
                      'NIH',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                    ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyNavigationButton(
                  componentKey: MyBanner.componentKey,
                  child: isShrink
                      ? CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              MemoryImage(base64Decode(settings.logo)),
                        )
                      : Text(
                          'NIH',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                ),
                SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyNavigationButton(
                        componentKey: MyFAQ.componentKey,
                        child: Text('FAQ',
                            style: TextStyle(
                                color: isShrink ? Colors.black : Colors.white)),
                      ),
                      MyNavigationButton(
                        componentKey: MyProducts.componentKey,
                        child: Text(
                          'Produk Kami',
                          style: TextStyle(
                              color: isShrink ? Colors.black : Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FilledButton(
                            onPressed: () {
                              Scrollable.ensureVisible(
                                MyContactUsForm.componentKey.currentContext ??
                                    context,
                                duration: const Duration(milliseconds: 800),
                              );

                              if (Scaffold.of(context).isDrawerOpen) {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              'Kontak Kami',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
