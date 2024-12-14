import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/namer_observer.dart';
import 'package:namer_app/navigation/navigation.dart';
import 'package:namer_app/wordpair/wordpair.dart';

void main() {
  Bloc.observer = const NamerObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WordPairBloc()),
        BlocProvider(create: (_) => NavigationBloc()),
      ],
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NavigationRailDestination> _buildDestinations() {
    return NavigationPage.values.map((page) {
      switch (page) {
        case NavigationPage.generator:
          return const NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          );
        case NavigationPage.favorite:
          return const NavigationRailDestination(
            icon: Icon(Icons.favorite),
            label: Text('Favorites'),
          );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              body: Row(
                children: [
                  SafeArea(
                    child: NavigationRail(
                      extended: constraints.maxWidth >= 600,
                      destinations: _buildDestinations(),
                      onDestinationSelected: (value) {
                        final selectedPage = NavigationPage.values[value];
                        switch (selectedPage) {
                          case NavigationPage.generator:
                            context
                                .read<NavigationBloc>()
                                .add(const NavigateToGeneratorPage());
                          case NavigationPage.favorite:
                            context
                                .read<NavigationBloc>()
                                .add(const NavigateToFavoritesPage());
                        }
                      },
                      selectedIndex: state.page.pageNumber,
                    ),
                  ),
                  Expanded(
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: IndexedStack(
                        index: state.page.pageNumber,
                        children: const [
                          GeneratorPage(),
                          FavoritesPage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
