import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utilis/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPostion;

  LocationInput(this.onSelectPostion);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      final staticMapImage = LocationUtil.generateLocationPreviewImage(
          latitude: locData.latitude, longitude: locData.longitude);

      setState(() {
        _previewImageUrl = staticMapImage;
      });

      widget.onSelectPostion(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true, builder: (context) => MapScreen()));

    final staticMapImage = LocationUtil.generateLocationPreviewImage(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);

    setState(() {
      _previewImageUrl = staticMapImage;
    });

    widget.onSelectPostion(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: Colors.red,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('Localização não informada!')
              : ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
              ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: _getCurrentUserLocation, 
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
           ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 20,), 
              Text('Localização Atual', style: TextStyle(fontSize: 17),)
            ],
          )
        ),
         ElevatedButton(
          onPressed: _selectOnMap, 
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
           ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Icon(Icons.map),
              SizedBox(width: 20,), 
              Text('Selecionar no Mapa', style: TextStyle(fontSize: 17),)
            ],
          )
        ),
      ],
    );
  }
}
