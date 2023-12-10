import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nasi_igut_han/widgets/socmed_icon_button.dart';

class MyAboutUs extends StatelessWidget {
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
      url: 'https://www.instagram.com/m.daffailhami/',
    ),
    MySocmedIconButton(
      icon: FaIcon(FontAwesomeIcons.tiktok),
      tooltip: 'TikTok',
      url: 'https://tiktok.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Lorem ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const TextSpan(
                          text:
                              "ipsum dolor sit, amet consectetur adipisicing elit. Unde consequuntur saepe accusantium nam dolorem in, odit placeat sit possimus repudiandae eum porro quibusdam facilis aut ratione accusamus animi ut ipsum!",
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
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
