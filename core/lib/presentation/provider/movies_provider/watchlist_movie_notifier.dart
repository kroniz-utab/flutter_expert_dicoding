import '../../../utils/state_enum.dart';
import '../../../domain/entities/movie_entities/movie.dart';
import '../../../domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        if (moviesData.isEmpty) {
          _watchlistState = RequestState.Empty;
          _message = 'Watchlist kamu masih kosong nih!';
          notifyListeners();
        } else {
          _watchlistState = RequestState.Loaded;
          _watchlistMovies = moviesData;
          notifyListeners();
        }
      },
    );
  }
}
