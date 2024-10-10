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
  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    return BlocBuilder<NavigationBloc, NavigationState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        switch (state.page) {
          case NavigationPage.generator:
            currentPage = const GeneratorPage();
          case NavigationPage.favorite:
            currentPage = const FavoritesPage();
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
                      onDestinationSelected: (value) {
                        if (NavigationPage.generator.pageNumber == value) {
                          context
                              .read<NavigationBloc>()
                              .add(const NavigateToGeneratorPage());
                        }
                        if (NavigationPage.favorite.pageNumber == value) {
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
