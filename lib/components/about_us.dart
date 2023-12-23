import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';
import 'package:nasi_igut_han/widgets/socmed_icon_button.dart';

class MyAboutUs extends ConsumerWidget {
  const MyAboutUs({Key? key}) : super(key: key);

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  static const List<MySocmedIconButton> socmedIconButtons = [
    MySocmedIconButton(
      icon: FaIcon(FontAwesomeIcons.whatsapp),
      tooltip: 'WhatsApp',
      url: 'https://wa.me/628875431260',
    ),
    MySocmedIconButton(
      icon: FaIcon(FontAwesomeIcons.instagram),
      tooltip: 'Instagram',
      url: 'https://www.instagram.com/nasi_igut_han/',
    ),
    MySocmedIconButton(
      icon: FaIcon(FontAwesomeIcons.tiktok),
      tooltip: 'TikTok',
      url: 'https://www.tiktok.com/@nasiiguthan',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: 20,
          ),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                children: [
                  SelectableText(
                    settings.aboutUs,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  const Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 50,
                    runSpacing: 15,
                    children: socmedIconButtons,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
