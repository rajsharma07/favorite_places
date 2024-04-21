import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.picimg});
  final void Function(File image) picimg;
  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? _selectedimg;
  void _takepic() async {
    final imagepickerr = ImagePicker();
    final pickedimg = await imagepickerr.pickImage(
        source: ImageSource.gallery, maxWidth: 600);
    if (pickedimg == null) {
      return;
    } else {
      setState(() {
        _selectedimg = File(pickedimg.path);
      });
      widget.picimg(_selectedimg!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: () {
        _takepic();
      },
      icon: Icon(Icons.camera),
      label: Text('Add Picture'),
    );
    if (_selectedimg != null) {
      content = GestureDetector(
        onTap: _takepic,
        child: Image.file(
          _selectedimg!,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        )),
        alignment: Alignment.center,
        child: content);
  }
}
