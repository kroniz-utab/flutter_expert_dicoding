import 'package:core/core.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class SearchTVShows {
  final TVRepository repository;

  SearchTVShows(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTVShows(query);
  }
}
