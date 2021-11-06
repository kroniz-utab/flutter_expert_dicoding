import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../../domain/entities/tv_entities/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetSimilarTVShows {
  final TVRepository repository;

  GetSimilarTVShows(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getSimilarTVShows(id);
  }
}
