import 'dart:io';

import 'package:uuid/uuid.dart';

const u = Uuid();

class Place {
  final String name;
  final String id;
  final File image;
  Place({
    required this.name,
    required this.image,
    String? id
  }):id = id ?? u.v4();
}
