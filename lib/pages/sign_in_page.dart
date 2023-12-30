import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasi_igut_han/models/admin.dart';
import 'package:nasi_igut_han/pages/home_page.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';
import 'package:nasi_igut_han/widgets/text_form_field.dart';
import 'package:http/http.dart' as http;

class MySignInPage extends ConsumerStatefulWidget {
  const MySignInPage({super.key});

  @override
  ConsumerState<MySignInPage> createState() => _MySignInPageState();
}

class _MySignInPageState extends ConsumerState<MySignInPage> {
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  final Admin _admin = Admin(email: '', password: '');

  Future<void> onResetPasswordButtonPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const SelectableText("Reset password"),
        content: const SelectableText(
          'Apakah kamu yakin ingin mereset password?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              final failedDialog = AlertDialog(
                title: const SelectableText('Reset password'),
                content:
                    const SelectableText('Gagal mengirim kode verifikasi!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Oke'),
                  )
                ],
              );

              try {
                final res = await http.get(
                  Uri.parse(
                      '${const String.fromEnvironment('API_URL')}/reset-password'),
                  headers: {'Content-Type': 'application/json'},
                );

                if (!context.mounted) return;

                final Map resBody = jsonDecode(res.body);

                if (!resBody['status']) {
                  showDialog(
                    context: context,
                    builder: (context) => failedDialog,
                  );
                } else {
                  var verificationCode = '';

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const SelectableText('Reset password'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SelectableText(
                              'Kode verifikasi telah dikirim ke ${const String.fromEnvironment('ADMIN_EMAIL')}\nSilahkan cek lalu masukkan kodenya di bawah ini!'),
                          MyTextFormField(
                            labelText: 'Kode Verifikasi',
                            onChanged: (String value) =>
                                verificationCode = value,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (verificationCode !=
                                resBody['verificationCode']) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const SelectableText('Reset Password'),
                                  content: const SelectableText(
                                      'Kode verifikasi salah!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Oke'),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              var newPassword = '';

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const SelectableText('Reset Password'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SelectableText(
                                          'Silahkan masukkan password yang baru'),
                                      MyTextFormField(
                                        labelText: 'Password Baru',
                                        onChanged: (String value) =>
                                            newPassword = value,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        final status = await ref
                                            .read(adminProvider.notifier)
                                            .changePassword(
                                                const String.fromEnvironment(
                                                    'ADMIN_EMAIL'),
                                                newPassword);

                                        if (!context.mounted) return;

                                        if (status) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const SelectableText(
                                                  'Reset password'),
                                              content: const SelectableText(
                                                  'Reset password berhasil!'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Oke'),
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const SelectableText(
                                                  'Reset password'),
                                              content: const SelectableText(
                                                  'Reset password gagal!'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Oke'),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Reset'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const Text('Verifikasi'),
                        ),
                      ],
                    ),
                  );
                }
              } catch (e) {
                if (!context.mounted) return;

                showDialog(
                  context: context,
                  builder: (context) => failedDialog,
                );
              }
            },
            child: const Text('Yakin'),
          ),
        ],
      ),
    );
  }

  Future<void> onFormSubmitted() async {
    if (await ref.read(adminProvider.notifier).signIn(_admin)) {
      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
      );
    } else {
      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const SelectableText('Email atau password salah'),
            content: const SelectableText(
              'Email atau password yang anda masukkan salah,\nsilahkan coba lagi!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Oke'),
              ),
            ],
          );
        },
      );
    }
  }

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
              MyTextFormField(
                labelText: 'Email',
                onFieldSubmitted: (value) => onFormSubmitted(),
                onChanged: (String value) {
                  _admin.email = value;
                },
              ),
              ValueListenableBuilder(
                valueListenable: _isPasswordVisible,
                builder: (context, value, child) {
                  return MyTextFormField(
                    labelText: 'Password',
                    obscureText: !value,
                    onFieldSubmitted: (value) => onFormSubmitted(),
                    onChanged: (String value) {
                      _admin.password = value;
                    },
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
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => onResetPasswordButtonPressed(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onFormSubmitted,
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
