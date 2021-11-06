import '../../../utils/state_enum.dart';
import '../../../domain/entities/tv_entities/tv.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/usecases/tv_usecases/get_popular_tv_show.dart';

class PopularTVNotifier extends ChangeNotifier {
  final GetPopularTVShows getPopularTVShows;

  PopularTVNotifier({
    required this.getPopularTVShows,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tvShows = [];
  List<TV> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTVShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVShows.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _tvShows = data;
        notifyListeners();
      },
    );
  }
}
