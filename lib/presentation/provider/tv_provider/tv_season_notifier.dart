import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entities/season_detail.dart';
import 'package:flutter/foundation.dart';

import 'package:ditonton/domain/usecases/tv_usecases/get_tv_season_detail.dart';

class TVSeasonNotifier extends ChangeNotifier {
  final GetTVSeasonDetail getTVSeasonDetail;

  TVSeasonNotifier({
    required this.getTVSeasonDetail,
  });

  late SeasonDetail _data;
  SeasonDetail get data => _data;

  RequestState _dataState = RequestState.Empty;
  RequestState get dataState => _dataState;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonDetail(int tvId, int season) async {
    _dataState = RequestState.Loading;
    notifyListeners();

    final result = await getTVSeasonDetail.execute(tvId, season);

    result.fold(
      (failure) {
        _dataState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seasonData) {
        _dataState = RequestState.Loaded;
        _data = seasonData;
        notifyListeners();
      },
    );
  }
}
