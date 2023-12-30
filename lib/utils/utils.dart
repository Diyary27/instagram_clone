import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage(ImageSource source) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? _file = await imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
}

showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
