import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/qna.dart';
import 'package:nasi_igut_han/providers/qnas_provider.dart';

class MyDeleteQNADialog extends ConsumerWidget {
  const MyDeleteQNADialog({super.key, required this.qna});

  final QNA qna;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Hapus QNA'),
      content:
          const SelectableText('Apakah kamu yakin ingin menghapus QNA ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () async {
            final success =
                await ref.read(qnasProvider.notifier).deleteOne(qna);

            if (success && context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Hapus',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
