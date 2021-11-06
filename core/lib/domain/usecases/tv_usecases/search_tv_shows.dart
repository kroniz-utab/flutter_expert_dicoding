import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class SearchTVShows {
  final TVRepository repository;

  SearchTVShows(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTVShows(query);
  }
}
