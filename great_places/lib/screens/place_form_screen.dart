import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceForm extends StatefulWidget {
  const PlaceForm({Key? key}) : super(key: key);

  @override
  _PlaceFormState createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPostion;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPostion = position;
    });
  }

  bool _isValidForm(){
    return _titleController.text.isNotEmpty && _pickedImage != null && _pickedPostion != null;
  }

  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedPostion!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Lugar'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Título',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.indigo, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ), 
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ImageInput(this._selectImage),
                      SizedBox(
                        height: 10,
                      ),
                      LocationInput(this._selectPosition)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: ElevatedButton(
                onPressed: _isValidForm() ? _submitForm : null, 
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 20,), 
                    Text('Adicionar', style: TextStyle(fontSize: 17),)
                  ],
                )
              ),
            )
          ],
        ));
  }
}
