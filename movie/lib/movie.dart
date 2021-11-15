library movie;

/// provider
export 'presentation/provider/movie_list_notifier.dart';
export 'presentation/provider/movie_detail_notifier.dart';
export 'presentation/provider/popular_movies_notifier.dart';
export 'presentation/provider/top_rated_movies_notifier.dart';

/// usecase
export 'domain/usecase/get_movie_detail.dart';
export 'domain/usecase/get_movie_recommendations.dart';
export 'domain/usecase/get_now_playing_movies.dart';
export 'domain/usecase/get_popular_movies.dart';
export 'domain/usecase/get_top_rated_movies.dart';

/// pages
export 'presentation/pages/home_movie_page.dart';
export 'presentation/pages/movie_detail_page.dart';
export 'presentation/pages/popular_movies_page.dart';
export 'presentation/pages/top_rated_movies_page.dart';
