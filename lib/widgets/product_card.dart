import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nasi_igut_han/components/delete_product_dialog.dart';
import 'package:nasi_igut_han/components/edit_product_form.dart';
import 'package:nasi_igut_han/models/product.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/pages/home_page.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProductCard extends ConsumerWidget {
  const MyProductCard({
    super.key,
    required this.product,
    this.showMenuButton = false,
  });

  final Product product;
  final bool showMenuButton;

  void onProductDetailButtonPressed(context, Settings settings) {
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
                      child: Image.memory(
                        base64Decode(product.image),
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
                          onPressed: () async {
                            final url =
                                '${settings.socmed1.link}?text=Halo! Apakah ${product.name}-nya masih tersedia?'
                                    .replaceAll(' ', '%20');

                            if (await canLaunchUrl(Uri.parse(url))) {
                              launchUrl(Uri.parse(url));
                            } else {
                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to launch URL!',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                  action: SnackBarAction(
                                    label: 'Dismiss',
                                    textColor:
                                        Theme.of(context).colorScheme.secondary,
                                    onPressed: () {
                                      MyHomePage.scaffoldKey.currentState
                                          ?.hideCurrentSnackBar();
                                      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            }
                          },
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
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider) as Settings;

    final title = Text(
      product.name,
      overflow: TextOverflow.ellipsis,
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
                  child: Image.memory(
                    base64Decode(product.image),
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
                            Expanded(
                              child: title,
                            ),
                            PopupMenuButton(
                              tooltip: 'Buka menu',
                              onSelected: (value) {
                                if (value == 1) {
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        MyEditProductForm(product: product),
                                  );
                                } else if (value == 2) {
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        MyDeleteProductDialog(product: product),
                                  );
                                }
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
                      onPressed: () =>
                          onProductDetailButtonPressed(context, settings),
                      child: const Text('Detail Produk'),
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
