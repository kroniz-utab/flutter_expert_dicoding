import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_entities/movie.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChange>(_onQueryChange);
  }

  @override
  Stream<SearchState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 42));

  FutureOr<void> _onQueryChange(
      OnQueryChange event, Emitter<SearchState> emit) async {
    final query = event.query;
    emit(SearchLoading());
    final result = await _searchMovies.execute(query);

    result.fold(
      (failure) {
        emit(SearchError(failure.message));
      },
      (data) {
        data.isEmpty ? emit(SearchEmpty()) : emit(SearchHasData(data));
      },
    );
  }
}
