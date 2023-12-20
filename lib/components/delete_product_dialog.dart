import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/product.dart';
import 'package:nasi_igut_han/providers/products_provider.dart';

class MyDeleteProductDialog extends ConsumerWidget {
  const MyDeleteProductDialog({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Hapus Produk'),
      content:
          const SelectableText('Apakah kamu yakin ingin menghapus Produk ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () async {
            final success =
                await ref.read(productsProvider.notifier).deleteOne(product);

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
