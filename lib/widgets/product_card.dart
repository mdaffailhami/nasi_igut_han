import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nasi_igut_han/models/product.dart';

class MyProductCard extends StatelessWidget {
  const MyProductCard({
    super.key,
    required this.product,
    this.showMenuButton = false,
  });

  final Product product;
  final bool showMenuButton;

  void onProductDetailButtonPressed(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(5),
          content: SizedBox(
            width: 260,
            height: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 6),
                      SelectableText(
                        product.description,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: const Color.fromARGB(255, 114, 114, 114),
                              fontSize: 13,
                            ),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        product.price.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: FilledButton.icon(
                          icon: const FaIcon(FontAwesomeIcons.whatsapp),
                          onPressed: () {},
                          label: const Text('Pesan Sekarang'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = SelectableText(
      product.name,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
    );

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        // side: BorderSide(
        //   width: 0.7,
        //   color: Theme.of(context).colorScheme.outline,
        // ),
      ),
      surfaceTintColor: const Color(0xFFFFFFFF),
      elevation: 7,
      child: SizedBox(
        width: 260,
        height: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !showMenuButton
                      ? title
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            title,
                            PopupMenuButton(
                              tooltip: 'Buka menu',
                              onSelected: (value) {
                                // if (value == 1) {
                                //   showDialog(
                                //     context: context,
                                //     builder: (_) => MyEditQNAForm(qna: qna),
                                //   );
                                // } else if (value == 2) {
                                //   showDialog(
                                //     context: context,
                                //     builder: (_) => MyDeleteQNADialog(qna: qna),
                                //   );
                                // }
                              },
                              itemBuilder: (context) {
                                return const [
                                  PopupMenuItem(value: 1, child: Text('Edit')),
                                  PopupMenuItem(value: 2, child: Text('Hapus')),
                                ];
                              },
                            ),
                          ],
                        ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color.fromARGB(255, 114, 114, 114),
                          fontSize: 13,
                        ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    product.price.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => onProductDetailButtonPressed(context),
                      child: Text('Detail Produk'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
