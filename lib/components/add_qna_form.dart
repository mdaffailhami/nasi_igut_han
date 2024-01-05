import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/qna.dart';
import 'package:nasi_igut_han/providers/qnas_provider.dart';
import 'package:nasi_igut_han/widgets/text_form_field.dart';

class MyAddQNAForm extends ConsumerStatefulWidget {
  const MyAddQNAForm({super.key});

  @override
  ConsumerState<MyAddQNAForm> createState() => _MyAddQNAFormState();
}

class _MyAddQNAFormState extends ConsumerState<MyAddQNAForm> {
  final _qna = QNA(question: '', answer: '');

  Future<void> onFormSubmitted() async {
    final success = await ref.read(qnasProvider.notifier).insertOne(_qna);

    if (success && context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const SelectableText('Tambah QNA'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFormField(
            labelText: 'Question',
            onChanged: (String value) => _qna.question = value,
          ),
          const SizedBox(height: 15),
          MyTextFormField(
            labelText: 'Answer',
            onChanged: (String value) => _qna.answer = value,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () => onFormSubmitted(),
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
