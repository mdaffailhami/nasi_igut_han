import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasi_igut_han/components/text_form_field.dart';

class MySignInPage extends StatefulWidget {
  const MySignInPage({super.key});

  @override
  State<MySignInPage> createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText(
                'Selamat Datang',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SvgPicture.asset(
                'assets/Sign In Character.svg',
                width: 180,
                height: 180,
              ),
              const MyTextFormField(labelText: 'Email'),
              ValueListenableBuilder(
                valueListenable: _isPasswordVisible,
                builder: (context, value, child) {
                  return MyTextFormField(
                    labelText: 'Password',
                    obscureText: !value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isPasswordVisible.value = !value;
                      },
                      icon: value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: SelectableText.rich(
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyMedium,
                  TextSpan(
                    text: 'Lupa Password? ',
                    children: [
                      TextSpan(
                          text: 'Reset',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Masuk'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
