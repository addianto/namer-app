import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const GeneratorPageNavigation());

  void goToPage(int pageNumber) {
    switch (pageNumber) {
      case GeneratorPageNavigation.number:
        emit(const GeneratorPageNavigation());
      case FavoritePageNavigation.number:
        emit(const FavoritePageNavigation());
      default:
        emit(state);
        addError('Invalid or unknown page identifier $pageNumber');
    }
  }
}
