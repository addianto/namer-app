import 'package:another_namer_app/navigation/navigation.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavigationBloc', () {
    late NavigationBloc bloc;

    setUp(() {
      bloc = NavigationBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is GeneratorPageNavigation', () {
      expect(bloc.state, isA<GeneratorPageNavigation>());
    });

    blocTest<NavigationBloc, NavigationState>(
      'emits GeneratorPageNavigation when NavigateToGeneratorPage is added',
      build: () => bloc,
      act: (bloc) => bloc.add(const NavigateToGeneratorPage()),
      expect: () => [isA<GeneratorPageNavigation>()],
      verify: (bloc) => expect(bloc.state.page, NavigationPage.generator),
    );

    blocTest<NavigationBloc, NavigationState>(
      'emits FavoritePageNavigation when NavigateToFavoritesPage is added',
      build: () => bloc,
      act: (bloc) => bloc.add(const NavigateToFavoritesPage()),
      expect: () => [isA<FavoritePageNavigation>()],
      verify: (bloc) => expect(bloc.state.page, NavigationPage.favorite),
    );
  });
}
