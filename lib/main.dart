import 'package:core/core.dart';
import 'package:about/about_page.dart';
import 'package:ditonton/main_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVListNotifier>(),
        ),
        ChangeNotifierProvider<TvDetailNotifier>(
          create: (context) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider<WatchlistTVNotifier>(
          create: (context) => di.locator<WatchlistTVNotifier>(),
        ),
        ChangeNotifierProvider<TVSearchNotifier>(
          create: (context) => di.locator<TVSearchNotifier>(),
        ),
        ChangeNotifierProvider<PopularTVNotifier>(
          create: (context) => di.locator<PopularTVNotifier>(),
        ),
        ChangeNotifierProvider<TopRatedTVNotifier>(
          create: (context) => di.locator<TopRatedTVNotifier>(),
        ),
        ChangeNotifierProvider<TVSeasonNotifier>(
          create: (context) => di.locator<TVSeasonNotifier>(),
        ),
        // bloc
        BlocProvider(
          create: (context) => di.locator<SearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: MainPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case mainRoutes:
              return CupertinoPageRoute(builder: (_) => MainPage());
            case movieRoutes:
              return CupertinoPageRoute(builder: (_) => HomeMoviePage());
            case popularMovieRoutes:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMovieRoutes:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoutes:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchRoutes:
              final args = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  isMovieSearch: args,
                ),
              );
            case watchlistRoutes:
              return CupertinoPageRoute(builder: (_) => WatchlistMoviesPage());
            case aboutRoutes:
              return CupertinoPageRoute(builder: (_) => AboutPage());
            case tvRoutes:
              return CupertinoPageRoute(
                builder: (context) => HomeTVPage(),
              );
            case popularTVRoutes:
              return CupertinoPageRoute(
                builder: (_) => PopularTVPage(),
              );
            case topRatedTVRoutes:
              return CupertinoPageRoute(
                builder: (context) => TopRatedTVPage(),
              );
            case tvDetailRoutes:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case seasonDetailRoutes:
              final dataMap = settings.arguments as Map;
              return CupertinoPageRoute(
                builder: (context) => SeasonDetailPage(
                  tvId: dataMap['tvId'],
                  season: dataMap['seasonNumber'],
                  tvPosterPath: dataMap['tvPosterPath'],
                  seasonList: dataMap['seasonList'],
                  tvName: dataMap['tvName'],
                ),
              );
            default:
              return CupertinoPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
