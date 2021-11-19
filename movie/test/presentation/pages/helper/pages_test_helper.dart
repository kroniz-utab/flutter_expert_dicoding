import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';
import 'package:watchlist/watchlist.dart';

@GenerateMocks([
  MovieDetailBloc,
  MovieListBloc,
  MoviePopularBloc,
  MovieRecommendationBloc,
  MovieTopRatedBloc,
  MovieWatchlistBloc,
])
void main() {}
