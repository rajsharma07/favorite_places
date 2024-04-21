import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/model/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getdb() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbpath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE favplaces(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
  }, version: 1);

  return db;
}

class FavPlacesNotifier extends StateNotifier<List<Place>> {
  FavPlacesNotifier() : super(const []);
  Future<void> loaddata() async {
    final db = await _getdb();
    final data = await db.query('favplaces');
    final places = data.map((e) {
      return Place(
        name: e['title'] as String,
        image: File(e['image'] as String),
        id: e['id'] as String
      );
    }).toList();
    state = places;
  }

  void addplace(String name, File imagesrc) async {
    final apdir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(imagesrc.path);
    imagesrc.copy('${apdir.path}/$filename');
    Place p = Place(name: name, image: imagesrc);

    final db = await _getdb();
    db.insert(
        'favplaces', {'id': p.id, 'title': p.name, 'image': p.image.path});
    state = [p, ...state];
  }
}

var favplaceprovider =
    StateNotifierProvider<FavPlacesNotifier, List<Place>>((ref) {
  return FavPlacesNotifier();
});
