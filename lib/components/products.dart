import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/add_product_form.dart';
import 'package:nasi_igut_han/models/product.dart';
import 'package:nasi_igut_han/models/rupiah.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';
import 'package:nasi_igut_han/widgets/product_card.dart';

class MyProducts extends ConsumerWidget {
  const MyProducts({super.key});

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(adminProvider);

    final title =
        Text('Produk Kami', style: Theme.of(context).textTheme.headlineLarge);
    return Column(
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
                                return const MyAddProductForm();
                              },
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah Produk'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        const Divider(),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          runSpacing: 14,
          children: [
            MyProductCard(
              showMenuButton: admin != null,
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
            MyProductCard(
              showMenuButton: admin != null,
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
            MyProductCard(
              showMenuButton: admin != null,
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
            MyProductCard(
              showMenuButton: admin != null,
              product: Product(
                name: 'Akane Kurokawa',
                description: 'Dijual waifu tercantik & terjenius di dunia',
                imageUrl:
                    'https://i.pinimg.com/736x/27/fd/71/27fd71e5108c40a02034cf15daf76c58.jpg',
                price: Rupiah(10000),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
