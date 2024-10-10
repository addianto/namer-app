part of 'wordpair_cubit.dart';

@immutable
sealed class WordPairState extends Equatable {
  const WordPairState({
    required this.current,
    required this.favorites,
  });

  final WordPair current;
  final List<WordPair> favorites;

  @override
  List<Object?> get props => [current, favorites];
}

final class WordPairInitial extends WordPairState {
  WordPairInitial() : super(current: WordPair.random(), favorites: []);
}

final class WordPairUpdated extends WordPairState {
  const WordPairUpdated({required super.current, required super.favorites});
}
