import 'package:flutter/material.dart';
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
          Text('FAQ',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white)),
          const Divider(),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 12,
            children: [
              MyQnACard(
                question: 'Sejak kapan mulai belajar pemrograman?',
                answer: '12 September 2020, kelas 11 MA, & umur 16 tahun',
              ),
              MyQnACard(
                question:
                    'Sarannya dong channel YouTube buat belajar pemrograman yang mudah dipahami?',
                answer: 'Web Programming UNPAS dan Kelas Terbuka',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
