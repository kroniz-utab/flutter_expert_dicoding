import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie_usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie_usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/movie_usecases/save_watchlist.dart';
import 'package:core/domain/usecases/tv_usecases/get_popular_tv_show.dart';
import 'package:core/domain/usecases/tv_usecases/get_similar_tv_shows.dart';
import 'package:core/domain/usecases/tv_usecases/get_top_rated_tv_show.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_on_the_air.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_season_detail.dart';
import 'package:core/domain/usecases/tv_usecases/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/tv_usecases/get_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tv_usecases/remove_tv_watchlist.dart';
import 'package:core/domain/usecases/tv_usecases/save_tv_watchlist.dart';
import 'package:core/presentation/provider/movies_provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movies_provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/movies_provider/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movies_provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movies_provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tv_provider/popular_tv_notifier.dart';
import 'package:core/presentation/provider/tv_provider/top_rated_tv_notifier.dart';
import 'package:core/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:core/presentation/provider/tv_provider/tv_list_notifier.dart';
import 'package:core/presentation/provider/tv_provider/tv_season_notifier.dart';
import 'package:core/presentation/provider/tv_provider/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';

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
