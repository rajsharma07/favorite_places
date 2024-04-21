import 'package:favorite_places/providers/provider.dart';
import 'package:favorite_places/screen/add_place.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends ConsumerState<MainScreen> {
  List<Place> p = [];
  late Future<void> placesfuture;
  @override
  void initState() {
    super.initState();
    placesfuture = ref.read(favplaceprovider.notifier).loaddata();
  }

  @override
  Widget build(BuildContext context) {
    p = ref.watch(favplaceprovider);
    print(p);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPlaces(),
                  ),
                );
              },
              icon: const Icon(Icons.add_a_photo))
        ],
      ),
      body: FutureBuilder(
        future: placesfuture,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: p.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(p[index].image),
                      ),
                      title: Text(p[index].name),
                    );
                  },
                );
        },
      ),
    );
  }
}
