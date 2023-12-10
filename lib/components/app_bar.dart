import 'package:flutter/material.dart';
import 'package:nasi_igut_han/components/about_us.dart';
import 'package:nasi_igut_han/components/banner.dart';
import 'package:nasi_igut_han/components/contact_us_form.dart';
import 'package:nasi_igut_han/components/faq.dart';
import 'package:nasi_igut_han/other/responsive_builder.dart';
import 'package:nasi_igut_han/widgets/navigation_button.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.isShrink});

  final bool isShrink;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 350,
      flexibleSpace: const FlexibleSpaceBar(
        background: MyBanner(),
      ),
      title: MyResponsiveBuilder((_, isSmall, isMedium, isLarge) {
        if (isSmall) {
          return Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu,
                    color: isShrink ? Colors.black : Colors.white),
              ),
              Center(
                child: MyNavigationButton(
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
                ),
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyNavigationButton(
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
              ),
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyNavigationButton(
                      componentKey: MyAboutUs.componentKey,
                      child: Text(
                        'About Me',
                        style: TextStyle(
                            color: isShrink ? Colors.black : Colors.white),
                      ),
                    ),
                    MyNavigationButton(
                      componentKey: MyFAQ.componentKey,
                      child: Text('FAQ',
                          style: TextStyle(
                              color: isShrink ? Colors.black : Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
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
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
