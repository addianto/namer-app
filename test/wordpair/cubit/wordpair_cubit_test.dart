import 'package:bloc_test/bloc_test.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/wordpair/cubit/wordpair_cubit.dart';

void main() {
  group('WordPairCubit', () {
    late WordPairCubit cubit;

    setUp(() {
      cubit = WordPairCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is WordPairInitial', () {
      expect(cubit.state, isA<WordPairInitial>());
    });

    blocTest<WordPairCubit, WordPairState>(
      'emits WordPairUpdated with new pair when createNewPair is called',
      build: () => cubit,
      act: (bloc) => bloc.createNewPair(),
      expect: () => [isA<WordPairUpdated>()],
      verify: (bloc) => expect(cubit.state.current, isA<WordPair>()),
    );

    blocTest<WordPairCubit, WordPairState>(
      'emits WordPairUpdated with added favorite when addToFavorites is called',
      build: () => cubit,
      seed: () => WordPairUpdated(
        current: WordPair('foo', 'bar'),
        favorites: const [],
      ),
      act: (bloc) => cubit.addToFavorites(),
      expect: () => [
        WordPairUpdated(
          current: WordPair('foo', 'bar'),
          favorites: [WordPair('foo', 'bar')],
        ),
      ],
      verify: (bloc) =>
          expect(cubit.state.favorites, contains(cubit.state.current)),
    );

    blocTest<WordPairCubit, WordPairState>(
      '''
      emits WordPairUpdated with removed favorites 
      when removeFromFavorites is called
      ''',
      build: () => cubit,
      seed: () => WordPairUpdated(
        current: WordPair('foo', 'bar'),
        favorites: [WordPair('foo', 'bar')],
      ),
      act: (bloc) => cubit.removeFromFavorites(WordPair('foo', 'bar')),
      expect: () => [
        WordPairUpdated(
          current: WordPair('foo', 'bar'),
          favorites: const [],
        ),
      ],
      verify: (bloc) => expect(
        cubit.state.favorites,
        isNot(contains(WordPair('foo', 'bar'))),
      ),
    );
  });
}
