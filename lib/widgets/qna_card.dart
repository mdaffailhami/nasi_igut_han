import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/edit_qna_form.dart';
import 'package:nasi_igut_han/models/qna.dart';
import 'package:nasi_igut_han/providers/qnas_provider.dart';

class MyQnACard extends ConsumerWidget {
  const MyQnACard({
    Key? key,
    required this.qna,
    this.showEditAndDeleteButton = false,
  }) : super(key: key);

  final QNA qna;
  final bool showEditAndDeleteButton;

  @override
  Widget build(BuildContext context, ref) {
    final card = Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: Text(
                      'Q',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  VerticalDivider(
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: SelectableText(
                        qna.question,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: Text(
                      'A',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  VerticalDivider(
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: SelectableText(
                        qna.answer,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (!showEditAndDeleteButton) {
      return card;
    } else {
      return Stack(
        children: [
          card,
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    showDialog(
                      context: context,
                      builder: (_) => MyEditQNAForm(qna: qna),
                    );
                  } else if (value == 2) {
                    ref.read(qnasProvider.notifier).deleteOne(qna);
                  }
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(value: 1, child: Text('Edit')),
                    PopupMenuItem(value: 2, child: Text('Hapus')),
                  ];
                },
              ),
            ),
          ),
        ],
      );
    }
  }
}
