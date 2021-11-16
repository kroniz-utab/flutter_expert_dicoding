import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTVShows _searchTVShows;

  SearchTvBloc(this._searchTVShows) : super(SearchTvEmpty()) {
    on<OnQueryTvChange>(_onQueryTvChange);
  }

  FutureOr<void> _onQueryTvChange(
      OnQueryTvChange event, Emitter<SearchTvState> emit) async {
    final query = event.query;
    emit(SearchTvEmpty());

    final result = await _searchTVShows.execute(query);

    result.fold(
      (failure) {
        emit(SearchTvError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(SearchTvEmpty()) : emit(SearchTvHasData(data));
      },
    );
  }

  @override
  Stream<SearchTvState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 200));
}
