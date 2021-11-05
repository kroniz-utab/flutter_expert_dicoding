import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:flutter/foundation.dart';

import 'package:ditonton/domain/usecases/tv_usecases/search_tv_shows.dart';

class TVSearchNotifier extends ChangeNotifier {
  final SearchTVShows searchTVShows;

  TVSearchNotifier({
    required this.searchTVShows,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _searchResult = [];
  List<TV> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSerach(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTVShows.execute(query);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (result) {
        if (result.length == 0) {
          _state = RequestState.Empty;
          _message =
              'Yah, acara yang kamu cari tidak ada :(, coba dengan keyword yang lain';
          notifyListeners();
        } else {
          _searchResult = result;
          _state = RequestState.Loaded;
          notifyListeners();
        }
      },
    );
  }
}
