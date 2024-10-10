part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToGeneratorPage extends NavigationEvent {
  const NavigateToGeneratorPage();
}

class NavigateToFavoritesPage extends NavigationEvent {
  const NavigateToFavoritesPage();
}
