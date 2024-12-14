part of 'wordpair_bloc.dart';

@immutable
sealed class WordPairEvent extends Equatable {
  const WordPairEvent();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [pair];
}

class ToggleFavorite extends WordPairEvent {
  const ToggleFavorite();
}
