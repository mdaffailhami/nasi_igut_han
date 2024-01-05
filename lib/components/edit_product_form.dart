import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasi_igut_han/models/product.dart';
import 'package:nasi_igut_han/models/rupiah.dart';
import 'package:nasi_igut_han/providers/products_provider.dart';
import 'package:nasi_igut_han/widgets/text_form_field.dart';

class MyEditProductForm extends ConsumerStatefulWidget {
  const MyEditProductForm({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<MyEditProductForm> createState() => _MyEditProductFormState();
}

class _MyEditProductFormState extends ConsumerState<MyEditProductForm> {
  final _pickedImage = ValueNotifier<String?>(null);
  final _pricePreview = ValueNotifier<String>('');

  final _product =
      Product(name: '', description: '', price: Rupiah(0), image: '');

  Future<void> onFormSubmitted() async {
    final success = await ref
        .read(productsProvider.notifier)
        .replaceOne(widget.product, _product);

    if (success && context.mounted) Navigator.pop(context);
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final String newImage = base64Encode(await image.readAsBytes());

    _pickedImage.value = newImage;
    _product.image = newImage;
  }

  @override
  Widget build(BuildContext context) {
    _product.id = widget.product.id;
    _product.name = widget.product.name;
    _product.description = widget.product.description;
    _product.price = widget.product.price;
    _product.image = widget.product.image;

    _pricePreview.value = '(${widget.product.price})';
    _pickedImage.value = widget.product.image;

    const Size imageSize = Size(140, 140);

    return AlertDialog(
      title: const SelectableText('Edit Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => pickImage(),
            child: Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: _pickedImage,
                  builder: (context, value, child) {
                    if (value == null) {
                      return Image.asset(
                        'assets/select_image.jpeg',
                        width: imageSize.width,
                        height: imageSize.height,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return Image.memory(
                        base64Decode(value),
                        width: imageSize.width,
                        height: imageSize.height,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: imageSize.width,
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    color: Colors.black45,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          MyTextFormField(
            labelText: 'Nama',
            onChanged: (String value) => _product.name = value,
            initialValue: widget.product.name,
          ),
          const SizedBox(height: 15),
          MyTextFormField(
            labelText: 'Deskripsi',
            onChanged: (String value) => _product.description = value,
            maxLines: null,
            initialValue: widget.product.description,
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder(
            valueListenable: _pricePreview,
            builder: (context, value, child) {
              return MyTextFormField(
                labelText: 'Harga',
                keyboardType: TextInputType.number,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                suffix: Text(value),
                onChanged: (String value) {
                  _product.price.nilai = int.parse(value);
                  _pricePreview.value = '(${_product.price})';
                },
                initialValue: widget.product.price.nilai.toString(),
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () => onFormSubmitted(),
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
