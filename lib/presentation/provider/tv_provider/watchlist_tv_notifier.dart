import 'package:flutter/foundation.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_tvshow.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  List<TV> _watchlistTVShow = [];
  List<TV> get watchlistTVShow => _watchlistTVShow;

  RequestState _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  final GetWatchlistTVShows getWatchlistTVShows;

  WatchlistTVNotifier({
    required this.getWatchlistTVShows,
  });

  Future<void> fetchWatchlistTVShow() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTVShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
      },
      (data) {
        _watchlistState = RequestState.Loaded;
        _watchlistTVShow = data;
        notifyListeners();
      },
    );
  }
}
