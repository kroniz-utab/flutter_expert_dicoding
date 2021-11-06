import 'package:flutter/foundation.dart';

import '../../../utils/state_enum.dart';
import '../../../domain/entities/tv_entities/tv.dart';
import '../../../domain/entities/tv_entities/tv_detail.dart';
import '../../../domain/usecases/tv_usecases/get_similar_tv_shows.dart';
import '../../../domain/usecases/tv_usecases/get_tv_recommendations.dart';
import '../../../domain/usecases/tv_usecases/get_tv_show_detail.dart';
import '../../../domain/usecases/tv_usecases/get_watchlist_tv_status.dart';
import '../../../domain/usecases/tv_usecases/remove_tv_watchlist.dart';
import '../../../domain/usecases/tv_usecases/save_tv_watchlist.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVShowDetail getTVShowDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetSimilarTVShows getSimilarTVShows;
  final GetWatchlistTVStatus getWatchlistTVStatus;
  final SaveTVWatchList saveTVWatchList;
  final RemoveTVWatchlist removeTVWatchlist;

  TvDetailNotifier({
    required this.getTVShowDetail,
    required this.getTVRecommendations,
    required this.getSimilarTVShows,
    required this.getWatchlistTVStatus,
    required this.saveTVWatchList,
    required this.removeTVWatchlist,
  });

  late TVDetail _tvShow;
  TVDetail get tvShow => _tvShow;

  RequestState _tvShowState = RequestState.Empty;
  RequestState get tvShowState => _tvShowState;

  List<TV> _tvRecommendations = [];
  List<TV> get tvRecommendations => _tvRecommendations;

  RequestState _tvRecommendationsState = RequestState.Empty;
  RequestState get tvRecommendationsState => _tvRecommendationsState;

  List<TV> _similarTVShows = [];
  List<TV> get similarTVShows => _similarTVShows;

  RequestState _similarTVState = RequestState.Empty;
  RequestState get similarTvState => _similarTVState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedtoWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchDetailTVShow(int id) async {
    _tvShowState = RequestState.Loading;
    _tvRecommendationsState = RequestState.Loading;
    _similarTVState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTVShowDetail.execute(id);
    final recommendationResult = await getTVRecommendations.execute(id);
    final similarResult = await getSimilarTVShows.execute(id);

    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (detail) {
        _tvShowState = RequestState.Loaded;
        _tvShow = detail;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _tvRecommendationsState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (recommendation) {
            _tvRecommendationsState = RequestState.Loaded;
            _tvRecommendations = recommendation;
            notifyListeners();

            similarResult.fold(
              (failure) {
                _similarTVState = RequestState.Error;
                _message = failure.message;
                notifyListeners();
              },
              (similar) {
                _similarTVState = RequestState.Loaded;
                _similarTVShows = similar;
                notifyListeners();
              },
            );
          },
        );
      },
    );
  }

  Future<void> addWatchlist(TVDetail tv) async {
    final result = await saveTVWatchList.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TVDetail tv) async {
    final result = await removeTVWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistTVStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
