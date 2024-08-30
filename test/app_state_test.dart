import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/app_state.dart';

void main() {
  group('MyAppState', () {
    late MyAppState state;

    setUp(() {
      state = MyAppState();
    });

    test('initial state is correct', () {
      expect(state.current, isNotNull);
      expect(state.favorites, isEmpty);
    });

    test('getNext() creates a new WordPair', () {
      // Setup
      final initialPair = state.current;

      // Exercise
      state.getNext();

      // Verify
      expect(state.current, isNot(equals(initialPair)));
    });

    test('getNext() notifies listeners', () {
      // Setup
      var isNotified = false;
      state.addListener(() {
        isNotified = true;
      });

      // Exercise
      state.getNext();

      // Verify
      expect(isNotified, isTrue);
    });

    test('toggleFavorite() adds and removes a WordPair from favorites', () {
      // Setup
      final initialPair = state.current;
      expect(state.favorites.contains(initialPair), isFalse);

      // Exercise & Verify
      state.toggleFavorite();
      expect(state.favorites.contains(initialPair), isTrue);

      state.toggleFavorite();
      expect(state.favorites.contains(initialPair), isFalse);
    });

    test('toggleFavorite() notifies listeners', () {
      // Setup
      var isNotified = false;
      state.addListener(() {
        isNotified = true;
      });

      // Exercise
      state.toggleFavorite();

      // Verify
      expect(isNotified, isTrue);
    });
  });
}
