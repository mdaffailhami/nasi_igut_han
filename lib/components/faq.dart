import 'package:flutter/material.dart';
import 'package:nasi_igut_han/models/qna.dart';
import 'package:nasi_igut_han/widgets/qna_card.dart';

class MyFAQ extends StatelessWidget {
  const MyFAQ({Key? key}) : super(key: key);

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  @override
  Widget build(BuildContext context) {
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
