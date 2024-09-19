import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'wordpair_state.dart';

class WordPairCubit extends Cubit<WordPairState> {
  WordPairCubit() : super(WordPairInitial());

  void createNewPair() {
    final newPair = WordPair.random();
    emit(WordPairUpdated(current: newPair, favorites: state.favorites));
  }

  void addToFavorites() {
    final newFavorites = List<WordPair>.from(state.favorites)
      ..add(state.current);
    emit(WordPairUpdated(current: state.current, favorites: newFavorites));
  }

  void removeFromFavorites(WordPair pair) {
    final newFavorites = List<WordPair>.from(state.favorites)..remove(pair);
    emit(WordPairUpdated(current: state.current, favorites: newFavorites));
  }

  void toggleFavorite() {
    if (state.favorites.contains(state.current)) {
      removeFromFavorites(state.current);
    } else {
      addToFavorites();
    }
  }
}
