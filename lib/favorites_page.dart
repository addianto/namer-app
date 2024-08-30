import 'package:flutter/material.dart';
import 'package:namer_app/app_state.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(child: Text('No favorites yet.'));
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text('You have ${appState.favorites.length} favorites:'),
        ),
        ...appState.favorites.map((e) => e.asString).map(
              (e) => ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(e),
              ),
            ),
      ],
    );
  }
}
