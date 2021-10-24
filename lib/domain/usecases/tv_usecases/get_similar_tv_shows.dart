import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetSimilarTVShows {
  final TVRepository repository;

  GetSimilarTVShows(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getSimilarTVShows(id);
  }
}
