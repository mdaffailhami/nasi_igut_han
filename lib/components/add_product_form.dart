import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasi_igut_han/models/product.dart';
import 'package:nasi_igut_han/models/rupiah.dart';
import 'package:nasi_igut_han/widgets/text_form_field.dart';

class MyAddProductForm extends ConsumerStatefulWidget {
  const MyAddProductForm({super.key});

  @override
  ConsumerState<MyAddProductForm> createState() => _MyAddProductFormState();
}

class _MyAddProductFormState extends ConsumerState<MyAddProductForm> {
  File? _pickedImage;
  Uint8List _pickedWebImage = Uint8List(8);
  final _pricePreview = ValueNotifier<String>('');

  final _product =
      Product(name: '', description: '', price: Rupiah(0), imageUrl: '');

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (!kIsWeb) {
      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
      }
    } else if (kIsWeb) {
      if (image != null) {
        _pickedWebImage = await image.readAsBytes();
        _pickedImage = File('a');
      }
    } else {
      debugPrint('Terjadi kesalahan!');
    }
  }

  Future<void> onFormSubmitted() async {
    // final success = await ref.read(qnasProvider.notifier).insertOne(_qna);

    // if (success && context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const Size imageSize = Size(140, 140);

    return AlertDialog(
      title: const SelectableText('Tambah Produk'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => pickImage(),
            child: Stack(
              children: [
                // foto != null
                //     ? Image.file(
                //         foto as File,
                //         width: imageSize.width,
                //         height: imageSize.height,
                //         fit: BoxFit.cover,
                //       )
                // :

                _pickedImage == null
                    ? Image.asset(
                        'assets/profile.png',
                        width: imageSize.width,
                        height: imageSize.height,
                        fit: BoxFit.cover,
                      )
                    : kIsWeb
                        ? Image.memory(
                            _pickedWebImage,
                            width: imageSize.width,
                            height: imageSize.height,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _pickedImage!,
                            width: imageSize.width,
                            height: imageSize.height,
                            fit: BoxFit.cover,
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
            onFieldSubmitted: (_) => onFormSubmitted(),
          ),
          const SizedBox(height: 15),
          MyTextFormField(
            labelText: 'Description',
            onChanged: (String value) => _product.description = value,
            onFieldSubmitted: (_) => onFormSubmitted(),
          ),
          const SizedBox(height: 15),
          ValueListenableBuilder(
            valueListenable: _pricePreview,
            builder: (context, value, child) {
              return MyTextFormField(
                labelText: 'Price',
                keyboardType: TextInputType.number,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                suffix: Text(value),
                onChanged: (String value) {
                  _product.price.nilai = num.parse(value);
                  _pricePreview.value = '(${_product.price})';
                },
                onFieldSubmitted: (_) => onFormSubmitted(),
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
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
