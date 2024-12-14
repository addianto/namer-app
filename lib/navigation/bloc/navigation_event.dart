part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

class NavigateToGeneratorPage extends NavigationEvent {
  const NavigateToGeneratorPage();
}

class NavigateToFavoritesPage extends NavigationEvent {
  const NavigateToFavoritesPage();
}
