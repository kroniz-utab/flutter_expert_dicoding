library movie;

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

/// bloc
export 'presentation/bloc/movie_detail/movie_detail_bloc.dart';
export 'presentation/bloc/movie_now_playing/movie_list_bloc.dart';
export 'presentation/bloc/movie_popular/movie_popular_bloc.dart';
export 'presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
export 'presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
