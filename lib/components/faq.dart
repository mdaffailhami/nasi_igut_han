import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/qna.dart';
import 'package:nasi_igut_han/providers/admin.dart';
import 'package:nasi_igut_han/widgets/qna_card.dart';

class MyFAQ extends ConsumerWidget {
  const MyFAQ({Key? key}) : super(key: key);

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(adminProvider);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.06,
        30,
        MediaQuery.of(context).size.width * 0.06,
        50,
      ),
      child: Column(
        children: [
          Text(
            'FAQ',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white),
          ),
          admin == null
              ? Center(child: Text('BUKAN ADMIN'))
              : Center(child: Text('ADMIN')),
          const Divider(),
          FutureBuilder<List<QNA>>(
            future: QNA.find(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cards = snapshot.data?.map((qna) {
                  return MyQnACard(question: qna.question, answer: qna.answer);
                });

                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 12,
                  children: cards!.toList(),
                );
              } else if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return Center(
                  child: Text(
                    'Gagal memuat data!',
                    style: Theme.of(context).textTheme.headlineSmall,
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
