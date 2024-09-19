import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/wordpair/cubit/wordpair_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordPairCubit, WordPairState>(
      builder: (context, state) {
        if (state.favorites.isEmpty) {
          return const Center(child: Text('No favorites yet.'));
        }

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('You have ${state.favorites.length} favorites:'),
            ),
            ...state.favorites.map((e) => e.asString).map(
                  (e) => ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(e),
                  ),
                ),
          ],
        );
      },
    );
  }
}
