import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future init() async {
  IOClient ioClient = await SSLPinning.ioClient;

  // bloc
  // search bloc
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  // watchlist bloc
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  // movies bloc
  locator.registerFactory(() => MovieListBloc(locator()));
  locator.registerFactory(() => MoviePopularBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => MovieTopRatedBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  // tv bloc
  locator.registerFactory(() => TvListBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => TvPopularBloc(locator()));
  locator.registerFactory(() => TvRecommendationBloc(locator()));
  locator.registerFactory(() => TvSimilarBloc(locator()));
  locator.registerFactory(() => TvTopRatedBloc(locator()));
  locator.registerFactory(() => TvSeasonDetailBloc(locator()));

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
      () => MovieRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => ioClient);
}
