import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/qna.dart';
import 'package:nasi_igut_han/providers/qnas_provider.dart';
import 'package:nasi_igut_han/widgets/text_form_field.dart';

class MyEditQNAForm extends ConsumerStatefulWidget {
  const MyEditQNAForm({super.key, required this.qna});

  final QNA qna;

  @override
  ConsumerState<MyEditQNAForm> createState() => _MyEditQNAFormState();
}

class _MyEditQNAFormState extends ConsumerState<MyEditQNAForm> {
  final _qna = QNA(question: '', answer: '');

  Future<void> onFormSubmitted() async {
    final success =
        await ref.read(qnasProvider.notifier).replaceOne(widget.qna, _qna);

    if (success && context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _qna.id = widget.qna.id;
    _qna.question = widget.qna.question;
    _qna.answer = widget.qna.answer;

    return AlertDialog(
      title: const SelectableText('Edit QNA'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFormField(
            labelText: 'Question',
            initialValue: widget.qna.question,
            onChanged: (String value) => _qna.question = value,
            onFieldSubmitted: (_) => onFormSubmitted(),
          ),
          const SizedBox(height: 15),
          MyTextFormField(
            labelText: 'Answer',
            initialValue: widget.qna.answer,
            onChanged: (String value) => _qna.answer = value,
            onFieldSubmitted: (_) => onFormSubmitted(),
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
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
