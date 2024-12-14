import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'wordpair_event.dart';
part 'wordpair_state.dart';

class WordPairBloc extends Bloc<WordPairEvent, WordPairState> {
  WordPairBloc() : super(WordPairInitial()) {
    on<CreateNewPair>(
      (event, emit) => emit(
        WordPairUpdated(
          current: WordPair.random(),
          favorites: state.favorites,
        ),
      ),
    );
    on<AddToFavorites>(
      (event, emit) => emit(
        WordPairUpdated(
          current: state.current,
          favorites: [...state.favorites, state.current],
        ),
      ),
    );
    on<RemoveFromFavorites>(
      (event, emit) => emit(
        WordPairUpdated(
          current: state.current,
          favorites: [...state.favorites]
            ..removeWhere((pair) => pair == event.pair),
        ),
      ),
    );
    on<ToggleFavorite>(
      (event, emit) {
        if (state.favorites.contains(state.current)) {
          add(RemoveFromFavorites(pair: state.current));
        } else {
          add(const AddToFavorites());
        }
      },
    );
  }
}
