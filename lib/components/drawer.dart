import 'package:flutter/material.dart';
import 'package:nasi_igut_han/components/about_us.dart';
import 'package:nasi_igut_han/components/contact_us_form.dart';
import 'package:nasi_igut_han/components/faq.dart';
import 'package:nasi_igut_han/widgets/navigation_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Theme.of(context).colorScheme.surface,
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
                    SizedBox(
                      height: 55,
                      child: MyNavigationButton(
                        componentKey: MyAboutUs.componentKey,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tentang Kami',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: MyNavigationButton(
                        componentKey: MyFAQ.componentKey,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'FAQ',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              'Kontak Kami',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 30,
                            runSpacing: 10,
                            children: MyAboutUs.socmedIconButtons,
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