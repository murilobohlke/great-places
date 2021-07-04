import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';

class PlaceDetail extends StatelessWidget {
  const PlaceDetail({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)?.settings.arguments as Place;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                  place.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.red,),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(Icons.place, color: Colors.white,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      place.location.address,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
               ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      isReadOnly: true,
                      initialLocation: place.location,
                    ),
                  ),
                );
              }, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Icon(Icons.map),
                  SizedBox(width: 20,), 
                  Text('Visualizar no Mapa', style: TextStyle(fontSize: 17),)
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}