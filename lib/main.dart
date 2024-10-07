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
        BlocProvider(create: (_) => WordPairCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
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
  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        switch (state.pageNumber) {
          case GeneratorPageNavigation.NUMBER:
            currentPage = const GeneratorPage();
          case FavoritePageNavigation.NUMBER:
            currentPage = const FavoritesPage();
          default:
            throw UnimplementedError('No widget for ${state.pageNumber}');
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              body: Row(
                children: [
                  SafeArea(
                    child: NavigationRail(
                      extended: constraints.maxWidth >= 600,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite),
                          label: Text('Favorites'),
                        ),
                      ],
                      selectedIndex: state.pageNumber,
                      onDestinationSelected: (value) {
                        // TODO
                      },
                    ),
                  ),
                  Expanded(
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: currentPage,
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
