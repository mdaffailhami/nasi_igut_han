import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasi_igut_han/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MySocmedIconButton extends StatelessWidget {
  const MySocmedIconButton({
    Key? key,
    required this.icon,
    required this.url,
  }) : super(key: key);

  final String icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          launchUrl(Uri.parse(url));
        } else {
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to launch URL!',
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              action: SnackBarAction(
                label: 'Dismiss',
                textColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  MyHomePage.scaffoldKey.currentState?.hideCurrentSnackBar();
                  // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      child: Ink.image(
        width: 25,
        height: 25,
        image: MemoryImage(base64Decode(icon)),
      ),
    );
  }
}
