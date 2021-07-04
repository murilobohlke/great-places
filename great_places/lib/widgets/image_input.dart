import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();

    PickedFile? imageFile =
        await _picker.getImage(source: ImageSource.camera, maxWidth: 600);

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: Colors.red,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(13),
                  child: Image.file(
                    _storedImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
              )
              : Text('Nenhuma Imagem!'),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: _takePicture, 
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
             ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Icon(Icons.add_a_photo),
                SizedBox(width: 20,),
                Text('Tirar Foto', style: TextStyle(fontSize: 17),)
              ],
            )
          ),
        ),
      ],
    );
  }
}
