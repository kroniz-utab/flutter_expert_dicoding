import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetSimilarTVShows {
  final TVRepository repository;

  GetSimilarTVShows(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getSimilarTVShows(id);
  }
}
