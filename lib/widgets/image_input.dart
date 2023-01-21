import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function selectedImage;
  const ImageInput({super.key,required this.selectedImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture()async{
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _storedImage = File(imageFile!.path);
    });
    
    final  appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await File(imageFile.path).copy("${appDir.path}/$fileName");
    widget.selectedImage(savedImage);
    // print(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage == null
              ? const Center(
                  child: Text(
                  'No image taken',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ))
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextButton.icon(
          onPressed: _takePicture,
          label: const Text('Take picture'),
          icon: const Icon(Icons.camera),
        ))
      ],
    );
  }
}
