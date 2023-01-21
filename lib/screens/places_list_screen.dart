import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: const Center(
            child: Text('You have no places yet! Try to add new place'),
          ),
          builder: (context, value, ch) => value.items.isEmpty
              ? ch!
              : ListView.builder(
                  itemCount: value.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(value.items[i].image),
                    ),
                    title: Text(value.items[i].title),
                  ),
                ),
        ));
  }
}
