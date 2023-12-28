import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyContactUsForm extends StatefulWidget {
  const MyContactUsForm({Key? key}) : super(key: key);

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => MyContactUsForm.componentKey;

  @override
  State<MyContactUsForm> createState() => _MyContactUsFormState();
}

class _MyContactUsFormState extends State<MyContactUsForm> {
  String _name = '';
  String _email = '';
  String _message = '';

  bool _isSending = false;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      sendMessageSuccessSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: const Text(
          'Pesan terkirim!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Tutup',
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      sendMessageFailedSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: Text(
          'Gagal mengirim pesan!',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          label: 'Tutup',
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> onSendButtonPressed() async {
    final Uri url = Uri.parse(
      '${const String.fromEnvironment('API_URL')}/contact-us',
    );

    final Map data = {
      'name': _name,
      'email': _email,
      'message': _message,
    };

    setState(() => _isSending = true);

    try {
      http.Response send = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      Map responseBody = jsonDecode(send.body);

      setState(() => _isSending = false);

      if (responseBody['status']) {
        sendMessageSuccessSnackBar();
      } else {
        sendMessageFailedSnackBar();
      }
    } catch (e) {
      setState(() => _isSending = false);

      sendMessageFailedSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.06,
        30,
        MediaQuery.of(context).size.width * 0.06,
        100,
      ),
      child: Column(
        children: [
          Text(
            'Kontak Kami',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white),
          ),
          const Divider(),
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 10,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nama',
                    ),
                    onChanged: (String value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    onChanged: (String value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.message),
                      labelText: 'Pesan',
                    ),
                    onChanged: (String value) {
                      _message = value;
                    },
                  ),
                  Visibility(
                    visible: _isSending,
                    child: LinearProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: FilledButton(
                      onPressed: () => onSendButtonPressed(),
                      child: const Text('Kirim'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
