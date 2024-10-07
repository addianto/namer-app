import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/navigation/navigation.dart';

void main() {
  group('NavigationCubit', () {
    late NavigationCubit cubit;

    setUp(() {
      cubit = NavigationCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is GeneratorPageNavigation', () {
      expect(cubit.state, const GeneratorPageNavigation());
    });

    blocTest<NavigationCubit, NavigationState>(
      'emits GeneratorPageNavigation when goToPage is called with GeneratorPageNavigation.NUMBER',
      build: () => cubit,
      act: (cubit) => cubit.goToPage(GeneratorPageNavigation.NUMBER),
      expect: () => [const GeneratorPageNavigation()],
    );

    blocTest<NavigationCubit, NavigationState>(
      'emits FavoritePageNavigation when goToPage is called with FavoritePageNavigation.NUMBER',
      build: () => cubit,
      act: (cubit) => cubit.goToPage(FavoritePageNavigation.NUMBER),
      expect: () => [const FavoritePageNavigation()],
    );

    blocTest<NavigationCubit, NavigationState>(
      'stays on the same page when goToPage is called with an invalid pageNumber',
      build: () => cubit,
      act: (cubit) => cubit.goToPage(2), // Invalid page number
      expect: () => [const GeneratorPageNavigation()],
    );
  });
}
