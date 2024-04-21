import 'package:flutter/material.dart';
import 'package:favorite_places/model/place.dart';

class FavPlace extends StatelessWidget {
  FavPlace({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.name),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            )
          ],
        ));
  }
}
