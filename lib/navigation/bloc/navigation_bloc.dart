import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const GeneratorPageNavigation()) {
    on<NavigateToGeneratorPage>(
      (event, emit) => emit(const GeneratorPageNavigation()),
    );
    on<NavigateToFavoritesPage>(
      (event, emit) => emit(const FavoritePageNavigation()),
    );
  }
}
