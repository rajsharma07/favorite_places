import 'dart:io';

import 'package:favorite_places/providers/provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaces extends ConsumerStatefulWidget {
  const AddPlaces({super.key});

  @override
  ConsumerState<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
  final namecontroller = TextEditingController();
  File? image;
  void pickedimage(File img) {
    image = img;
  }

  @override
  void dispose() {
    namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add place'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      label: const Text('Name of place'),
                      labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(
                    picimg: pickedimage,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('clear')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if(image != null && namecontroller.text.isNotEmpty){
                          ref.read(favplaceprovider.notifier).addplace(
                                namecontroller.text,image!
                              );
                          Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Add'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
