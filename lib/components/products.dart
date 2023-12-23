import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/add_product_form.dart';
import 'package:nasi_igut_han/models/product.dart';
import 'package:nasi_igut_han/models/rupiah.dart';
import 'package:nasi_igut_han/other/responsive_builder.dart';
import 'package:nasi_igut_han/providers/admin_provider.dart';
import 'package:nasi_igut_han/providers/products_provider.dart';
import 'package:nasi_igut_han/widgets/product_card.dart';

class MyProducts extends ConsumerWidget {
  const MyProducts({super.key});

  static final GlobalKey componentKey = GlobalKey();

  @override
  Key? get key => componentKey;

  void onAddButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const MyAddProductForm();
      },
    );
  }

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
                        child: MyResponsiveBuilder(
                          (context, isSmall, isMedium, isLarge) {
                            if (isSmall) {
                              return FloatingActionButton(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                onPressed: () => onAddButtonPressed(context),
                                child: Icon(
                                  Icons.add,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              );
                            } else {
                              return FilledButton.icon(
                                onPressed: () => onAddButtonPressed(context),
                                icon: const Icon(Icons.add),
                                label: const Text('Tambah Produk'),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
        const Divider(),
        FutureBuilder(
          future: ref.read(productsProvider.notifier).load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer(
                builder: (context, ref, child) {
                  final products = ref.watch(productsProvider);

                  final cards = (products as List).map((product) {
                    return MyProductCard(
                      product: product,
                      showMenuButton: admin != null,
                    );
                  });

                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 14,
                    runSpacing: 14,
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
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
