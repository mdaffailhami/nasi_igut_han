import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/contact_us_form.dart';
import 'package:nasi_igut_han/components/faq.dart';
import 'package:nasi_igut_han/components/products.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';
import 'package:nasi_igut_han/widgets/navigation_button.dart';
import 'package:nasi_igut_han/widgets/socmed_icon_button.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  Widget navTile(
    BuildContext context, {
    required String text,
    required GlobalKey componentKey,
  }) {
    return SizedBox(
      height: 55,
      child: MyNavigationButton(
        componentKey: componentKey,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    final socmedIconButtons = [
      MySocmedIconButton(
        icon: settings.socmed1.icon,
        url: settings.socmed1.link,
        // url: 'https://wa.me/628875431260',
      ),
      MySocmedIconButton(
        icon: settings.socmed2.icon,
        url: settings.socmed2.link,
        // url: 'https://www.instagram.com/nasi_igut_han/',
      ),
      MySocmedIconButton(
        icon: settings.socmed3.icon,
        url: settings.socmed3.link,
      ),
    ];
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png'),
            radius: 50,
          ),
          const SizedBox(height: 5),
          Text(
            'Nasi Igut Han',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 26),
          ),
          const Divider(),
          Expanded(
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    navTile(
                      context,
                      text: 'FAQ',
                      componentKey: MyFAQ.componentKey,
                    ),
                    navTile(
                      context,
                      text: 'Produk Kami',
                      componentKey: MyProducts.componentKey,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
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
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 30,
                            runSpacing: 10,
                            children: socmedIconButtons,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
