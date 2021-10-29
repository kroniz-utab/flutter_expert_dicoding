import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/main_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/season_detail_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movies_provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movies_provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movies_provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movies_provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movies_provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movies_provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_season_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/watchlist_tv_notifier.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

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
          create: (_) => di.locator<MovieSearchNotifier>(),
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
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MainPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => MainPage());
            case HomeMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final args = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  isMovieSearch: args,
                ),
              );
            case WatchlistMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => AboutPage());
            case HomeTVPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (context) => HomeTVPage(),
              );
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SeasonDetailPage.ROUTE_NAME:
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
              return CupertinoPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
