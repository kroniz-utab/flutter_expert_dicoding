library watchlist;

/// movie usecase
export 'domain/usecase/movie_usecases/get_watchlist_movies.dart';
export 'domain/usecase/movie_usecases/get_watchlist_status.dart';
export 'domain/usecase/movie_usecases/remove_watchlist.dart';
export 'domain/usecase/movie_usecases/save_watchlist.dart';

/// tv usecase
export 'domain/usecase/tv_usecases/get_watchlist_tv_status.dart';
export 'domain/usecase/tv_usecases/get_watchlist_tvshow.dart';
export 'domain/usecase/tv_usecases/remove_tv_watchlist.dart';
export 'domain/usecase/tv_usecases/save_tv_watchlist.dart';

/// provider
export 'presentation/provider/watchlist_movie_notifier.dart';
export 'presentation/provider/watchlist_tv_notifier.dart';

/// pages
export 'presentation/pages/watchlist_page.dart';
