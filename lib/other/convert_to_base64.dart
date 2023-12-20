import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<String> convertToBase64(XFile file) async {
  final String? fileMimeType = file.mimeType;
  final Uint8List fileBytes = await file.readAsBytes();
  final String base64File = base64Encode(fileBytes);

  return 'data:$fileMimeType;base64,$base64File';
}
