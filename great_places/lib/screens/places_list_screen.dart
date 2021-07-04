import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utilis/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares', style: TextStyle(fontFamily: 'Lobster'),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.indigo[900],  onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              } ,child: Icon(Icons.add, color: Colors.white,),),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting 
          ? Center(child: CircularProgressIndicator(),)
          : Consumer<GreatPlaces> (
          builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0 ? Center(
            child: Text('Nenhum local cadastrado!')
          ) : ListView.builder(
            itemCount: greatPlaces.itemsCount,
            itemBuilder: (ctx, i) => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red),
              margin: EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PLACE_DETAIL,
                    arguments: greatPlaces.itemByIndex(i)
                  );
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft:  Radius.circular(20), topRight:  Radius.circular(20)),
                      child: Image.file(
                        greatPlaces.itemByIndex(i).image,
                        height: MediaQuery.of(context).size.height/4,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        greatPlaces.itemByIndex(i).title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        greatPlaces.itemByIndex(i).location.address,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ), 
            )
          )
        ),
      )
    );
  }
}
