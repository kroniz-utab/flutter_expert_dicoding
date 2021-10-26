import 'package:ditonton/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_popular_tv_show.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_on_the_air.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetTVOnTheAir,
  GetPopularTVShows,
  GetTopRatedMovies,
])
void main() {}
