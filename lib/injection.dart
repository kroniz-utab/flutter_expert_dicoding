import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:search/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTVNotifier(
      getPopularTVShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTVNotifier(
      getTopRatedTVShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTVShowDetail: locator(),
      getTVRecommendations: locator(),
      getSimilarTVShows: locator(),
      getWatchlistTVStatus: locator(),
      removeTVWatchlist: locator(),
      saveTVWatchList: locator(),
    ),
  );
  locator.registerFactory(
    () => TVListNotifier(
      getTVOnTheAir: locator(),
      getPopularTVShows: locator(),
      getTopRatedTVShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TVSearchNotifier(
      searchTVShows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTVNotifier(
      getWatchlistTVShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TVSeasonNotifier(
      getTVSeasonDetail: locator(),
    ),
  );

  // bloc
  locator.registerFactory(() => SearchBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetPopularTVShows(locator()));
  locator.registerLazySingleton(() => GetSimilarTVShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVShows(locator()));
  locator.registerLazySingleton(() => GetTVOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => GetTVShowDetail(locator()));
  locator.registerLazySingleton(() => SearchTVShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVStatus(locator()));
  locator.registerLazySingleton(() => SaveTVWatchList(locator()));
  locator.registerLazySingleton(() => RemoveTVWatchlist(locator()));
  locator.registerLazySingleton(() => GetTVSeasonDetail(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
