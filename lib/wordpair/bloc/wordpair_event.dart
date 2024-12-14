part of 'wordpair_bloc.dart';

@immutable
sealed class WordPairEvent extends Equatable {
  const WordPairEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

class CreateNewPair extends WordPairEvent {
  const CreateNewPair();
}

class AddToFavorites extends WordPairEvent {
  const AddToFavorites();
}

class RemoveFromFavorites extends WordPairEvent {
  const RemoveFromFavorites({required this.pair});

  final WordPair pair;

  // coverage:ignore-start
  @override
  List<Object> get props => [pair];
  // coverage:ignore-end
}

class ToggleFavorite extends WordPairEvent {
  const ToggleFavorite();
}
