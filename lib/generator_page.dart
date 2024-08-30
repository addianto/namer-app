import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/app_state.dart';
import 'package:provider/provider.dart';

class BigCard extends StatelessWidget {
  const BigCard({
    required this.pair,
    super.key,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: '${pair.first} ${pair.second}',
        ),
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final pair = appState.current;
    final icon = appState.favorites.contains(pair)
        ? const Icon(Icons.favorite)
        : const Icon(Icons.favorite_border);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: appState.toggleFavorite,
                label: const Text('Like'),
                icon: icon,
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: appState.getNext,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
