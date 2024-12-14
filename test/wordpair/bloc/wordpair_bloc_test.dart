import 'package:bloc_test/bloc_test.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/wordpair/bloc/wordpair_bloc.dart';

void main() {
  group('WordPairBloc', () {
    late WordPairBloc bloc;

    setUp(() {
      bloc = WordPairBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is WordPairInitial', () {
      expect(bloc.state, isA<WordPairInitial>());
    });

    blocTest<WordPairBloc, WordPairState>(
      'emits WordPairUpdated with new pair when createNewPair is called',
      build: () => bloc,
      act: (bloc) => bloc.add(const CreateNewPair()),
      expect: () => [isA<WordPairUpdated>()],
      verify: (bloc) => expect(bloc.state.current, isA<WordPair>()),
    );

    blocTest<WordPairBloc, WordPairState>(
      'emits WordPairUpdated with added favorite when addToFavorites is called',
      build: () => bloc,
      seed: () => WordPairUpdated(
        current: WordPair('foo', 'bar'),
        favorites: const [],
      ),
      act: (bloc) => bloc.add(const AddToFavorites()),
      expect: () => [
        WordPairUpdated(
          current: WordPair('foo', 'bar'),
          favorites: [WordPair('foo', 'bar')],
        ),
      ],
      verify: (bloc) =>
          expect(bloc.state.favorites, contains(bloc.state.current)),
    );

    blocTest<WordPairBloc, WordPairState>(
      '''
      emits WordPairUpdated with removed favorites 
      when removeFromFavorites is called
      ''',
      build: () => bloc,
      seed: () => WordPairUpdated(
        current: WordPair('foo', 'bar'),
        favorites: [WordPair('foo', 'bar')],
      ),
      act: (bloc) =>
          bloc.add(RemoveFromFavorites(pair: WordPair('foo', 'bar'))),
      expect: () => [
        WordPairUpdated(
          current: WordPair('foo', 'bar'),
          favorites: const [],
        ),
      ],
      verify: (bloc) => expect(
        bloc.state.favorites,
        isNot(contains(WordPair('foo', 'bar'))),
      ),
    );

    blocTest<WordPairBloc, WordPairState>(
      '''
      given one favorite exists in the favorites
      when toggleFavorite is called
      then favorites become empty
      ''',
      build: () => bloc,
      seed: () => WordPairUpdated(
        current: WordPair('foo', 'bar'),
        favorites: [WordPair('foo', 'bar')],
      ),
      act: (bloc) => bloc.add(const ToggleFavorite()),
      expect: () => [
        WordPairUpdated(
          current: WordPair('foo', 'bar'),
          favorites: const [],
        ),
      ],
    );

    blocTest<WordPairBloc, WordPairState>(
      '''
      given no favorite exists in the favorites
      when toggleFavorite is called
      then favorites contain one favorite
      ''',
      build: () => bloc,
      seed: () => WordPairUpdated(
        current: WordPair('foo', 'bar'),
        favorites: const [],
      ),
      act: (bloc) => bloc.add(const ToggleFavorite()),
      expect: () => [
        WordPairUpdated(
          current: WordPair('foo', 'bar'),
          favorites: [WordPair('foo', 'bar')],
        ),
      ],
    );
  });
}
