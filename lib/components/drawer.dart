import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/about_us.dart';
import 'package:nasi_igut_han/components/contact_us_form.dart';
import 'package:nasi_igut_han/components/faq.dart';
import 'package:nasi_igut_han/components/products.dart';
import 'package:nasi_igut_han/components/sign_out_dialog.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';
import 'package:nasi_igut_han/widgets/navigation_button.dart';

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
    final admin = ref.watch(adminProvider);

    final drawer = Column(
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/profile.png'),
          radius: 50,
        ),
        const SizedBox(height: 5),
        Text(
          'Nasi Igut Han',
          style:
              Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 26),
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
                    text: 'Tentang Kami',
                    componentKey: MyAboutUs.componentKey,
                  ),
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
    );

    if (admin == null) {
      return Drawer(child: drawer);
    } else {
      return Drawer(
        child: Stack(
          children: [
            drawer,
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 5, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    tooltip: 'Keluar',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            const MySignOutDialog(closeDrawer: true),
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
