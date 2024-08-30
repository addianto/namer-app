import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  MyAppState()
      : _current = WordPair.random(),
        _favorites = {};

  WordPair _current;
  final Set<WordPair> _favorites;

  WordPair get current => _current;

  Set<WordPair> get favorites => _favorites;

  void getNext() {
    _current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (_favorites.contains(_current)) {
      _favorites.remove(_current);
    } else {
      _favorites.add(_current);
    }
    notifyListeners();
  }
}
