import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecase/get_top_rated_tv_show.dart';

class TopRatedTVNotifier extends ChangeNotifier {
  final GetTopRatedTVShows getTopRatedTVShows;
  TopRatedTVNotifier({
    required this.getTopRatedTVShows,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tvList = [];
  List<TV> get tvList => _tvList;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTVShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _tvList = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
