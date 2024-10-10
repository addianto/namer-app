part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState extends Equatable {
  const NavigationState({required this.pageNumber});

  final int pageNumber;

  @override
  List<Object> get props => [pageNumber];
}

final class GeneratorPageNavigation extends NavigationState {
  const GeneratorPageNavigation() : super(pageNumber: NUMBER);

  static const int NUMBER = 0;
}

final class FavoritePageNavigation extends NavigationState {
  const FavoritePageNavigation() : super(pageNumber: NUMBER);

  static const int NUMBER = 1;
}
