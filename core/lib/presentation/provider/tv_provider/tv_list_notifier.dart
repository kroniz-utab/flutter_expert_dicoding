import 'package:flutter/foundation.dart';

import '../../../utils/state_enum.dart';
import '../../../domain/entities/tv_entities/tv.dart';
import '../../../domain/usecases/tv_usecases/get_popular_tv_show.dart';
import '../../../domain/usecases/tv_usecases/get_top_rated_tv_show.dart';
import '../../../domain/usecases/tv_usecases/get_tv_on_the_air.dart';

class TVListNotifier extends ChangeNotifier {
  var _tvOnTheAirList = <TV>[];
  List<TV> get tvOnTheAir => _tvOnTheAirList;

  RequestState _tvOnTheAirState = RequestState.Empty;
  RequestState get tvOnTheAirState => _tvOnTheAirState;

  var _popularTvShowsList = <TV>[];
  List<TV> get popularTVShows => _popularTvShowsList;

  RequestState _popularTvShowsState = RequestState.Empty;
  RequestState get popularTVShowsState => _popularTvShowsState;

  var _topRatedTVShowsList = <TV>[];
  List<TV> get topRatedTVShows => _topRatedTVShowsList;

  RequestState _topRatedTVShowsState = RequestState.Empty;
  RequestState get topRatedTVShowsState => _topRatedTVShowsState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getTVOnTheAir,
    required this.getPopularTVShows,
    required this.getTopRatedTVShows,
  });

  final GetTVOnTheAir getTVOnTheAir;
  final GetPopularTVShows getPopularTVShows;
  final GetTopRatedTVShows getTopRatedTVShows;

  Future<void> fetchTVOnTheAir() async {
    _tvOnTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTVOnTheAir.execute();
    result.fold(
      (failure) {
        _tvOnTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _tvOnTheAirState = RequestState.Loaded;
        _tvOnTheAirList = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTVShows() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVShows.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvShowsState = RequestState.Loaded;
        _popularTvShowsList = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTVShows() async {
    _topRatedTVShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVShows.execute();
    result.fold(
      (failure) {
        _topRatedTVShowsState = RequestState.Error;
        _message = failure.message;
      },
      (tvData) {
        _topRatedTVShowsState = RequestState.Loaded;
        _topRatedTVShowsList = tvData;
      },
    );
  }
}
