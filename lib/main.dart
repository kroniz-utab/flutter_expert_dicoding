import 'package:core/core.dart';
import 'package:about/about_page.dart';
import 'package:ditonton/main_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/search.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // bloc
        // search bloc
        BlocProvider(
          create: (context) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchTvBloc>(),
        ),
        // watchlist bloc
        BlocProvider(
          create: (context) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvWatchlistBloc>(),
        ),
        // movies bloc
        BlocProvider(
          create: (context) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailBloc>(),
        ),
        // tv bloc
        BlocProvider(
          create: (context) => di.locator<TvListBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSimilarBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSeasonDetailBloc>(),
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
