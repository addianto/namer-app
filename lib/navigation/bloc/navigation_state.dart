part of 'navigation_bloc.dart';

enum NavigationPage {
  generator(0),
  favorite(1);

  const NavigationPage(this.pageNumber);
  final int pageNumber;
}

@immutable
sealed class NavigationState extends Equatable {
  const NavigationState({required this.page});

  final NavigationPage page;

  @override
  List<Object> get props => [page];
}

final class GeneratorPageNavigation extends NavigationState {
  const GeneratorPageNavigation() : super(page: NavigationPage.generator);
}

final class FavoritePageNavigation extends NavigationState {
  const FavoritePageNavigation() : super(page: NavigationPage.favorite);
}
