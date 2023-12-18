import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/add_qna_form.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';
import 'package:nasi_igut_han/providers/qnas_provider.dart';
import 'package:nasi_igut_han/widgets/qna_card.dart';

class MyFAQ extends ConsumerWidget {
  const MyFAQ({Key? key}) : super(key: key);

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(adminProvider);

    final title = Text(
      'FAQ',
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(color: Colors.white),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.06,
        30,
        MediaQuery.of(context).size.width * 0.06,
        50,
      ),
      child: Column(
        children: [
          admin == null
              ? title
              : SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      title,
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const MyAddQNAForm();
                                },
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Tambah QNA'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          const Divider(),
          FutureBuilder(
            future: ref.read(qnasProvider.notifier).load(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer(
                  builder: (context, ref, child) {
                    final qnas = ref.watch(qnasProvider);

                    final cards = (qnas as List).map((qna) {
                      return MyQnACard(
                        qna: qna,
                        showMenuButton: admin != null,
                      );
                    });

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 12,
                      children: cards.toList(),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return Center(
                  child: Text(
                    'Gagal memuat data!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
