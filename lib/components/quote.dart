import 'package:flutter/material.dart';

class MyQuote extends StatelessWidget {
  const MyQuote({Key? key}) : super(key: key);

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.06,
        vertical: 80,
      ),
      child: Center(
        child: SelectableText(
          'Ini Quote lurr UWU..',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
