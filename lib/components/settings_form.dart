import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasi_igut_han/models/settings.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';
import 'package:nasi_igut_han/widgets/image_form_field.dart';
import 'package:nasi_igut_han/widgets/text_form_field.dart';

enum PickImage { logo, banner, background }

class MySettingsForm extends ConsumerStatefulWidget {
  const MySettingsForm({super.key});

  @override
  ConsumerState<MySettingsForm> createState() => _MySettingsFormState();
}

class _MySettingsFormState extends ConsumerState<MySettingsForm> {
  late final Settings settings =
      Settings.fromMap((ref.read(settingsProvider) as Settings).toMap());

  final _pickedLogo = ValueNotifier<String>(defaultImage);
  final _pickedBanner = ValueNotifier<String>(defaultImage);
  final _pickedBackground = ValueNotifier<String>(defaultImage);

  @override
  void initState() {
    super.initState();

    // settings = ref.read(settingsProvider) as Settings;
    _pickedLogo.value = settings.logo;
    _pickedBanner.value = settings.banner;
    _pickedBackground.value = settings.background;
  }

  Future<void> onFormSubmitted() async {
    final success = await ref.read(settingsProvider.notifier).set(settings);

    if (success && context.mounted) Navigator.pop(context);
  }

  Future<void> pickImage(PickImage pickImage) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final String newImage = base64Encode(await image.readAsBytes());

    if (pickImage == PickImage.logo) {
      _pickedLogo.value = newImage;
      settings.logo = newImage;
    }
    if (pickImage == PickImage.banner) {
      _pickedBanner.value = newImage;
      settings.banner = newImage;
    }
    if (pickImage == PickImage.background) {
      _pickedBackground.value = newImage;
      settings.background = newImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const SelectableText('Setelan'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => pickImage(PickImage.logo),
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _pickedLogo,
                    builder: (context, value, child) {
                      return Image.memory(
                        base64Decode(value),
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 140,
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
              labelText: 'Judul',
              onChanged: (String value) => settings.title = value,
              onFieldSubmitted: (_) => onFormSubmitted(),
              initialValue: settings.title,
            ),
            const SizedBox(height: 15),
            MyTextFormField(
              labelText: 'Quote',
              onChanged: (String value) => settings.quote = value,
              onFieldSubmitted: (_) => onFormSubmitted(),
              initialValue: settings.quote,
            ),
            const SizedBox(height: 15),
            MyTextFormField(
              labelText: 'Tentang Kami',
              onChanged: (String value) => settings.aboutUs = value,
              onFieldSubmitted: (_) => onFormSubmitted(),
              initialValue: settings.aboutUs,
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder(
              valueListenable: _pickedBanner,
              builder: (context, value, child) {
                return MyImageFormField(
                  label: 'Banner',
                  image: MemoryImage(base64Decode(value)),
                  onGantiButtonPressed: () => pickImage(PickImage.banner),
                );
              },
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder(
              valueListenable: _pickedBackground,
              builder: (context, value, child) {
                return MyImageFormField(
                  label: 'Background',
                  image: MemoryImage(base64Decode(value)),
                  onGantiButtonPressed: () => pickImage(PickImage.background),
                );
              },
            ),
          ],
        ),
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
