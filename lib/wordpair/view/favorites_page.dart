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

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('You have ${state.favorites.length} favorites:'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.favorites.length,
                // TODO(addianto): Figure out how to push down the InkWell
                // wrapper to be defined inside the FavoriteItem class
                itemBuilder: (context, index) => InkWell(
                  onTap: () => context
                      .read<WordPairCubit>()
                      .removeFromFavorites(state.favorites[index]),
                  child: FavoriteItem(
                    item: state.favorites[index].asString,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({required this.item, super.key});

  final String item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.favorite),
      title: Text(item),
    );
  }
}
