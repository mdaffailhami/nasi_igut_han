import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 67,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/profile.png'),
        ),
        const SizedBox(height: 4),
        const Text(
          'Nasi Igut Han',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
            children: [
              const TextSpan(text: '<'),
              TextSpan(
                  text: 'code',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryContainer)),
              const TextSpan(text: '> Programmer'),
              TextSpan(
                  text: ' | ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryContainer)),
              const TextSpan(text: 'Developer </'),
              TextSpan(
                  text: 'code',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryContainer)),
              const TextSpan(text: '>'),
            ],
          ),
        ),
      ],
    );
  }
}
